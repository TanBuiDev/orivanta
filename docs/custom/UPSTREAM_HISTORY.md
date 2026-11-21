# Lịch sử đồng bộ upstream

## 2026-11-21 · Khởi tạo Orivanta

- Nguồn `jlcodes99/cockpit-tools`, nhánh `main`, commit `c004bf71be250cc2536fc91ef90638837f0013a0`, phiên bản khai báo 1.4.2.
- Clone đầy đủ với 2.143 commit tổ tiên của mốc gốc. Giữ nhánh theo dõi và tag upstream trong clone. Chỉ đẩy lịch sử liên quan đến `origin/main`; không đẩy bộ tag phát hành Cockpit Tools.
- Commit baseline bỏ workflow phát hành và làm nóng cache phát hành của Cockpit Tools. GitHub Actions của Orivanta vẫn hoạt động. Các công cụ phát hành upstream tiếp tục nằm trong lịch sử để phục vụ đối chiếu.
- Tích hợp nền tảng Orivanta giữ định dạng dữ liệu, provider và IPC. Kênh updater tắt. Rà soát đặc biệt nếu upstream sửa data path, bundle ID, OAuth callback, updater, locale hoặc các lớp CSS dùng chung.
- Vòng đồng bộ tiếp theo tạo nhánh `upstream-sync/*`, ghi SHA, tag, loại thay đổi, quyết định, xung đột và bằng chứng kiểm thử trước khi đưa lên PR.

### Phạm vi kiểm thử phiên bản đầu

Lần chạy CI mở rộng trên PR khởi tạo ghi nhận hai test upstream thất bại trong nhóm `codex_session_visibility::local_projects::account_state`: `account_project_switch_reconciles_native_and_parked_archives_by_owner` và `scoped_ssh_preferences_follow_the_outgoing_account_to_the_next_launch`. Mã và fixture của nhóm này giữ nguyên so với upstream. Khi đối chiếu mã, hàm kế thừa thiết lập tự kết nối trong nhóm này không có điểm gọi. CI bắt buộc kiểm tra nhóm sao lưu, sửa hiển thị phiên và các luồng cấu hình, nhập dữ liệu, gateway liên quan đến thay đổi. Rà soát hành vi SSH theo tài khoản trước khi mở rộng nhóm của CI. [Log lần chạy mở rộng](https://github.com/TanBuiDev/orivanta/actions/runs/44912926323/job/136873552306)
