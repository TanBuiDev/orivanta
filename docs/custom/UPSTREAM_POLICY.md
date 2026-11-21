# Chính sách cập nhật upstream

`origin` là đích ghi duy nhất. `upstream` dùng để fetch và xem xét. `main` theo dõi `origin/main`. Tạo `feature/*`, `fix/*`, `upstream-sync/*` và `security/*` từ `origin/main`. Giữ mốc upstream trong ancestry, không reset, không force-push `main` và không tự động tích hợp upstream vào `main`.

## Quy trình báo cáo

Workflow `upstream-check.yml` chạy theo lịch và có thể kích hoạt thủ công trên nhánh mặc định. Workflow chỉ đọc commit, tag và metadata release của Cockpit Tools. Mục Summary của run liệt kê commit chưa tích hợp, mức chênh lệch cây mã, tệp có khả năng xung đột và các bản phát hành gần đây. Catalog bản phát hành và các nhánh Git có thể thay đổi độc lập. Một commit cherry-pick vẫn có SHA khác và có thể xuất hiện trong danh sách cần đối chiếu.

## Đánh giá bằng Codex

Khi được yêu cầu xem xét upstream, thực hiện các bước sau trong phiên Codex hiện tại. Workflow GitHub không cần dịch vụ AI, khóa API hoặc secrets phát hành.

1. `git remote -v`, `git fetch origin --prune` và `git remote show upstream` để kiểm tra remotes và nhánh mặc định. `git fetch upstream --prune --tags` lấy commit và tag. Không đẩy tag Cockpit Tools lên origin.
2. Dùng `git merge-base origin/main upstream/main`, `git log --left-right --cherry-pick origin/main...upstream/main` và `git diff --name-status origin/main...upstream/main`. Đọc patch, thay đổi phụ thuộc, release notes và lịch sử quyết định. Nếu upstream đổi nhánh mặc định, thay `upstream/main` bằng nhánh phát hiện được.
3. Với mỗi nhóm thay đổi, ghi loại bảo mật, lỗi, tính năng, giao diện, bản địa hóa, phụ thuộc hoặc phá vỡ tương thích. Ghi miền ảnh hưởng, mức độ ưu tiên, kiểm tra cần chạy, xung đột và tác động đến giao diện, tiếng Việt, profile, OAuth, Tauri và cập nhật của Orivanta.
4. Chọn nhập bằng merge để giữ ancestry khi gói thay đổi phù hợp, cherry-pick theo commit khi chỉ cần bản sửa độc lập, điều chỉnh thủ công nếu thay đổi va chạm ranh giới Orivanta, hoặc bỏ qua nếu chi phí/rủi ro vượt lợi ích. Ghi rõ lý do. Khi xung đột phức tạp, báo tệp và phương án để người duy trì xem xét.
5. Dùng `git worktree add -b upstream-sync/YYYY-MM-DD ../orivanta-sync-YYYY-MM-DD origin/main`. Thực hiện tích hợp đã chọn tại worktree, dùng hồ sơ giả lập, đọc diff so với cả hai phía và chạy kiểm tra liên quan. Kiểm tra workflow upstream và mọi quyền, secret, URL tải và giá trị định danh trước khi đẩy.
6. Cập nhật lịch sử đồng bộ, đẩy riêng nhánh lên origin và tạo Pull Request nhắm vào `main` khi sẵn sàng. Đưa danh sách SHA, phân loại, quyết định, xung đột, kiểm tra đã chạy và giới hạn vào PR. Người duy trì duyệt và quyết định merge.

## Cấu hình bảo vệ trên GitHub

Trong **Settings → Branches → Add branch protection rule**, dùng pattern `main`. Bật yêu cầu Pull Request và giải quyết mọi thảo luận trước khi nhập. Bật kiểm tra bắt buộc `Orivanta CI required` từ GitHub Actions và yêu cầu nhánh cập nhật với `main`. Bật quy tắc với quản trị viên, tắt force push và xóa nhánh. Giữ merge commit khả dụng cho PR upstream cần ancestry. Không bật tự động merge. Khi có người duyệt độc lập, đặt một lượt duyệt bắt buộc và hủy duyệt cũ nếu PR có commit mới. [Tài liệu bảo vệ nhánh GitHub](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
