#!/usr/bin/env bash
set -euo pipefail

owner_repo=jlcodes99/cockpit-tools
upstream_url="https://github.com/$owner_repo.git"
base=$(git rev-parse --verify "${1:-HEAD}^{commit}")

remote_head=$(git ls-remote --symref "$upstream_url" HEAD)
branch=$(awk '$1 == "ref:" && $3 == "HEAD" { sub("^refs/heads/", "", $2); print $2 }' <<< "$remote_head")
if [[ -z "$branch" ]]; then
  echo "Unable to resolve the upstream default branch" >&2
  exit 1
fi
git check-ref-format "refs/heads/$branch"

tracking_ref=refs/upstream-check/default
git fetch --no-tags "$upstream_url" "+refs/heads/$branch:$tracking_ref" >&2
incoming=$(git rev-parse --verify "$tracking_ref^{commit}")
common=$(git merge-base "$base" "$incoming")
read -r outgoing_count incoming_count <<< "$(git rev-list --left-right --count "$base...$incoming")"

if [[ -z "${GH_TOKEN:-}" ]] || ! releases=$(gh api "repos/$owner_repo/releases?per_page=10"); then
  releases=$(curl --fail --silent --show-error --retry 2 "https://api.github.com/repos/$owner_repo/releases?per_page=10")
fi

printf '## Cockpit Tools upstream report\n\n'
printf -- '- Orivanta commit `%s`\n- Upstream `%s` at `%s`\n- Common ancestor `%s`\n' "$base" "$branch" "$incoming" "$common"
printf -- '- Commits only in Orivanta `%s`\n- Commits only upstream `%s`\n\n' "$outgoing_count" "$incoming_count"

if [[ "$incoming_count" != 0 ]]; then
  printf '### Incoming commits (up to 100)\n\n'
  git log --max-count=100 --format='    %h %s' "$base..$incoming"
  printf '\n### Incoming file changes (up to 200)\n\n'
  git diff --name-status "$common" "$incoming" | awk 'NR <= 200 {print "    " $0}'
  printf '\n### Files changed on both sides (up to 100)\n\n'
  overlap=$(comm -12 \
    <(git diff --no-renames --name-only "$common" "$base" | LC_ALL=C sort -u) \
    <(git diff --no-renames --name-only "$common" "$incoming" | LC_ALL=C sort -u))
  if [[ -z "$overlap" ]]; then
    printf 'No paths overlap in this comparison.\n'
  else
    awk 'NR <= 100 {print "    " $0}' <<< "$overlap"
  fi
  printf '\n'
else
  printf 'No incoming commits on the default branch.\n\n'
fi

printf '### Recent published releases\n\n'
remote_tags=$(git ls-remote --tags "$upstream_url")
release_rows=$(node -e '
  const releases = JSON.parse(require("node:fs").readFileSync(0, "utf8"));
  for (const release of releases.filter((release) => !release.draft)) {
    console.log([release.published_at, release.tag_name, release.html_url].join("\t"));
  }
' <<< "$releases")
while IFS=$'\t' read -r published tag url; do
  [[ -n "$tag" ]] || continue
  tag_commit=$(awk -v ref="refs/tags/$tag" '
    $2 == ref { object = $1 }
    $2 == ref "^{}" { peeled = $1 }
    END { print (peeled ? peeled : object) }
  ' <<< "$remote_tags")
  if [[ -z "$tag_commit" ]] || ! git cat-file -e "$tag_commit^{commit}" 2>/dev/null; then
    status="tag commit outside fetched history"
  elif git merge-base --is-ancestor "$tag_commit" "$base"; then
    status="already in Orivanta ancestry"
  else
    status="review needed"
  fi
  printf '    %s  %s  %s  %s\n' "$published" "$tag" "$status" "$url"
done <<< "$release_rows"
printf '\nReview the commits and releases under docs/custom/UPSTREAM_POLICY.md.\n'
