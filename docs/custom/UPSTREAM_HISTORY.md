# Lịch sử đồng bộ upstream

## 2026-11-21 · Khởi tạo Orivanta

- Nguồn `jlcodes99/cockpit-tools`, nhánh `main`, commit `c004bf71be250cc2536fc91ef90638837f0013a0`, phiên bản khai báo 1.4.2.
- Clone đầy đủ với 2.143 commit tổ tiên của mốc gốc. Giữ nhánh theo dõi và tag upstream trong clone. Chỉ đẩy lịch sử liên quan đến `origin/main`; không đẩy bộ tag phát hành Cockpit Tools.
- Commit baseline bỏ workflow phát hành và làm nóng cache phát hành của Cockpit Tools. GitHub Actions của Orivanta vẫn hoạt động. Các công cụ phát hành upstream tiếp tục nằm trong lịch sử để phục vụ đối chiếu.
- Tích hợp nền tảng Orivanta giữ định dạng dữ liệu, provider và IPC. Kênh updater tắt. Rà soát đặc biệt nếu upstream sửa data path, bundle ID, OAuth callback, updater, locale hoặc các lớp CSS dùng chung.
- Vòng đồng bộ tiếp theo tạo nhánh `upstream-sync/*`, ghi SHA, tag, loại thay đổi, quyết định, xung đột và bằng chứng kiểm thử trước khi đưa lên PR.
