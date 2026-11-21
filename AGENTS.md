# Chỉ dẫn phát triển Orivanta

Các quy tắc này áp dụng cho Codex và mọi coding agent làm việc trong repo.

## Trước khi sửa

- Đọc `docs/custom/ARCHITECTURE.md`, tài liệu liên quan và mã nguồn đang chạy. Xác định điểm vào React, IPC Tauri hoặc crate Rust và các caller trước khi đổi hợp đồng.
- Kiểm tra trạng thái Git, nhánh đang làm và các thay đổi có sẵn. Dùng `feature/*`, `fix/*`, `upstream-sync/*` hoặc `security/*` từ `origin/main`. Dùng worktree khi cần chạy song song.
- Giữ tên Orivanta, bundle ID, tài nguyên, hồ sơ riêng và kênh phát hành của repo này. Tái sử dụng thành phần và token giao diện. Giữ bản dịch tiếng Việt tự nhiên, khóa i18n và biến nội suy. Đọc `docs/custom/TRANSLATION_GUIDE.md`.
- Giữ phạm vi diff nhỏ để dễ cập nhật upstream. Giữ ghi công và giấy phép CC BY-NC-SA 4.0 cùng các giấy phép thành phần.

## Git và đồng bộ

- `origin` là `https://github.com/TanBuiDev/orivanta.git`, đích push duy nhất. `upstream` là `https://github.com/jlcodes99/cockpit-tools.git`, chỉ fetch và đọc. Giữ push URL của upstream là `DISABLED` trong mỗi clone.
- Không force-push hoặc reset `main` theo upstream. Không tự động merge vào `main`. Chuẩn bị Pull Request, bảo toàn ancestry theo chính sách và đưa xung đột phức tạp ra review. Không chấp nhận toàn bộ thay đổi upstream theo mặc định.
- Ghi mốc, commit hoặc tag, cách tích hợp, xung đột, kết quả kiểm tra và lý do bỏ qua tại `docs/custom/UPSTREAM_HISTORY.md`. Ghi quyết định kiến trúc có ảnh hưởng lâu dài trong tài liệu tương ứng.

## An toàn và kiểm chứng

- Không đọc, ghi hoặc tải lên tài khoản thật, token OAuth, cookie, khóa API, khóa ký, hoặc tệp hồ sơ bên ngoài phạm vi đã được phép. Dùng dữ liệu giả lập, hồ sơ cô lập và đầu ra đã che thông tin nhạy cảm.
- Giữ quyền Actions tối thiểu và quản lý secrets ở môi trường phát hành được duyệt. Không chạy mã upstream hoặc PR chưa duyệt với secrets sản xuất. Giữ updater tắt đến khi có hạ tầng phát hành đã ký của Orivanta.
- Rà soát advisory, lockfile, quyền Tauri, đăng ký deep link, phạm vi bind của API, luồng đọc thông tin xác thực và nguồn tải executable khi chúng thay đổi. Không đổi nghiệp vụ đăng nhập, chuyển tài khoản hay hạn mức trong PR giao diện.
- Chạy các kiểm tra liên quan đã khai báo trong `package.json` và CI. Tối thiểu kiểm tra kiểu, test liên quan và `git diff --check`; các thay đổi giao diện/locale cần build và kiểm tra locale. Với Rust, dùng fixture và lệnh `cargo test --locked` phù hợp. Kiểm tra chạy song song trên nền tảng bị ảnh hưởng khi sửa định danh và dữ liệu.
- Nêu rõ điều đã chạy, kết quả, phạm vi còn thiếu và giả định trong PR. Kết quả suy ra từ đọc mã cần được ghi riêng với kết quả thực nghiệm.
