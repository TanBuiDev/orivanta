const assert = require('node:assert/strict');
const { readFileSync, readdirSync } = require('node:fs');
const path = require('node:path');
const { test } = require('node:test');

const root = path.resolve(__dirname, '../..');
const read = (file) => readFileSync(path.join(root, file), 'utf8');
const json = (file) => JSON.parse(read(file));

test('desktop identity and updater stay isolated from Cockpit Tools', () => {
  const config = json('src-tauri/tauri.conf.json');
  assert.equal(config.productName, 'Orivanta');
  assert.equal(config.identifier, 'dev.tanbuidev.orivanta');
  assert.equal(config.mainBinaryName, 'orivanta');
  assert.deepEqual(config.plugins['deep-link'].desktop.schemes, ['orivanta']);
  assert.equal(config.bundle.windows.nsis.installerHooks, undefined);
  assert.equal(json('src-tauri/tauri.dev.conf.json').identifier, 'dev.tanbuidev.orivanta.dev');

  for (const file of readdirSync(path.join(root, 'src-tauri'))) {
    if (!/^tauri(?:\..+)?\.conf\.json$/.test(file)) continue;
    const overlay = json(`src-tauri/${file}`);
    assert.equal(overlay.plugins?.updater, undefined, file);
    assert.notEqual(overlay.bundle?.createUpdaterArtifacts, true, file);
  }
  for (const file of readdirSync(path.join(root, 'src-tauri/capabilities'))) {
    assert.doesNotMatch(read(`src-tauri/capabilities/${file}`), /"updater:/, file);
  }
  const startup = read('src-tauri/src/lib.rs');
  assert.doesNotMatch(startup, /tauri_plugin_updater::Builder|commands::update::install_linux_update,/);
  assert.doesNotMatch(read('crates/cockpit-core/src/modules/data_paths.rs'), /\.cockpit_tools|\.antigravity_cockpit|COCKPIT_TOOLS_DATA_DIR/);
});

function leaves(object, prefix = '') {
  return Object.fromEntries(Object.entries(object).flatMap(([key, value]) => {
    const name = prefix ? `${prefix}.${key}` : key;
    return typeof value === 'string' ? [[name, value]] : Object.entries(leaves(value, name));
  }));
}

function variables(value) {
  return Array.from(value.matchAll(/\{\{\s*([^}]+?)\s*\}\}/g), ([, name]) => name).sort();
}

test('Vietnamese and English overrides preserve keys and interpolation', () => {
  for (const language of ['en', 'vi']) {
    const base = leaves(json(`src/locales/${language}.json`));
    const overrides = leaves(json(`src/i18n/orivanta/${language}.json`));
    for (const [key, value] of Object.entries(overrides)) {
      assert.equal(typeof base[key], 'string', `${language}: ${key}`);
      assert.ok(value.trim(), `${language}: empty ${key}`);
      assert.deepEqual(variables(value), variables(base[key]), `${language}: ${key}`);
    }
  }
});

test('Rust parser and app-owned support storage avoid Cockpit Tools namespaces', () => {
  const importSource = read('src-tauri/src/modules/external_import.rs');
  assert.match(importSource, /matches!\(scheme, "orivanta" \| "orivanta-dev"\)/);
  assert.doesNotMatch(read('src-tauri/src/modules/codex_ssh.rs'), /\.join\("cockpit-tools"\)/);
  assert.doesNotMatch(read('src-tauri/src/modules/codex_device_restrictions.rs'), /\.join\("cockpit-tools-local"\)/);
  assert.doesNotMatch(read('src-tauri/src/modules/backup_storage.rs'), /Backups\/CockpitTools/);
});
