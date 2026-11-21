# Kiến trúc Orivanta

Orivanta là bản tùy biến phi thương mại của Cockpit Tools. Mốc gốc là `c004bf71be250cc2536fc91ef90638837f0013a0` (upstream `main`, phiên bản 1.4.2).

## Thành phần

- `src/main.tsx` và `src/App.tsx` khởi tạo React 19, i18next, giao diện cửa sổ và điều hướng. Vite biên dịch TypeScript và CSS. Các màn hình trong `src/pages` dùng thành phần chung tại `src/components`, Zustand tại `src/stores` và dịch vụ IPC tại `src/services`.
- `src-tauri/src/lib.rs` đăng ký lệnh và plugin Tauri v2. `src-tauri/src/commands` tiếp nhận IPC, còn `src-tauri/src/modules` xử lý nhà cung cấp, hạn mức, lưu trữ và dịch vụ cục bộ. Workspace Rust gồm ứng dụng, `crates/cockpit-core` và CLI.
- `src-tauri/capabilities` quy định quyền của WebView. OAuth, dữ liệu và tiến trình của từng công cụ AI có hợp đồng riêng. Sửa các ranh giới này cần kiểm thử độc lập bằng hồ sơ giả lập.

## Ranh giới với Cockpit Tools

| Khu vực | Quyết định |
| --- | --- |
| Đóng gói | Tauri dùng `dev.tanbuidev.orivanta`, bản dev dùng hậu tố `.dev`. Tên hiển thị và tên binary đóng gói thuộc Orivanta. Tên package/bin Cargo nội bộ và cấu trúc IPC giữ nguyên để tương thích mã nguồn và CI upstream. Installer không dùng hook sửa shortcut của Cockpit Tools. |
| Hồ sơ | Mặc định dùng `~/.orivanta`, `~/.orivanta_dev`, cùng thư mục instance Orivanta trong Windows Roaming. Biến cấu hình chính là `ORIVANTA_DATA_DIR` và `ORIVANTA_PROFILE`. Tên dự phòng và tệp tùy chọn chỉ thuộc Orivanta. Không chọn lại thư mục hồ sơ Cockpit Tools trong cấu hình thủ công. |
| OAuth và liên kết | `orivanta://` phục vụ nhập dữ liệu của ứng dụng. Bản dev đăng ký `orivanta-dev://`. ZCode yêu cầu callback `zcode://` từ nhà cung cấp. Orivanta giữ xác thực callback trong cửa sổ OAuth tích hợp hoặc luồng dán URL có sẵn, đồng thời không đăng ký `zcode://` trên hệ điều hành. Cổng callback loopback cố định của nhà cung cấp được giữ để tránh làm hỏng redirect đã đăng ký. Không thực hiện đồng thời hai phiên OAuth có cùng cổng của hai ứng dụng. |
| Công cụ AI bên ngoài | Các tên nhà cung cấp, nơi lưu thông tin của ứng dụng bên thứ ba, định dạng sao lưu và định danh truyền dữ liệu giữ nguyên. Các thao tác nhập hoặc đổi tài khoản do người dùng khởi tạo có thể tương tác với cùng một ứng dụng bên ngoài. |
| Kênh cập nhật | Tắt cập nhật tự động, bỏ cấu hình chữ ký và manifest upstream, quyền WebView và đường gọi cài Linux. Giao diện dẫn đến GitHub Releases của Orivanta. Ghi chú lịch sử nhúng vẫn là tài liệu tham khảo upstream. |
| Dịch vụ cục bộ | Giữ mặc định bind và xác thực upstream. Cổng OAuth nhà cung cấp vẫn có thể trùng khi chạy đồng thời. Cổng phát triển Vite và cổng API relay của profile dev được dành riêng cho Orivanta. |

Trước khi bật cập nhật tự động, cần tạo khóa ký Orivanta riêng, dựng quy trình tạo manifest và kiểm tra chữ ký trên Windows, macOS và Linux. Khóa riêng chỉ nằm trong kho secret được chủ repo phê duyệt. Manifest và tệp tải xuống thuộc kênh Orivanta. Xác minh cài song song bằng hồ sơ tổng hợp trước khi phát hành installer.

Giấy phép upstream ghi trong README và Cargo manifest là CC BY-NC-SA 4.0. Giữ thông báo bản quyền, nguồn gốc, ghi chú thay đổi và giấy phép của các thành phần bên thứ ba. [Điều khoản giấy phép](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
