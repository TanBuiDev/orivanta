# Thiết kế giao diện Orivanta

## Kiến trúc hiện tại

`App.tsx` kết nối điều hướng, trạng thái giao diện và trang được nạp theo nhu cầu. `SideNav` có giao diện cổ điển thu gọn và giao diện biểu tượng. Các trang dùng CSS riêng, CSS dùng chung trong `src/styles` và một số tiện ích Tailwind. `base.css` cung cấp biến màu, chữ, bề mặt, bán kính và bóng. Theme được chọn bằng `data-theme` và có các bảng màu tùy chọn qua `data-theme-color`. Giữ các điểm ngắt, bố cục nền tùy chỉnh, cửa sổ thẻ nổi và các thành phần Tauri hiện có.

## Quy ước thiết kế

| Thành phần | Quy ước |
| --- | --- |
| Màu và bề mặt | Dùng bề mặt trung tính với điểm nhấn xanh lục lam. Lấy màu từ biến ngữ nghĩa hiện có. Đèn báo hạn mức đi kèm nhãn hoặc con số. |
| Chữ và khoảng cách | Inter có bộ ký tự tiếng Việt, dự phòng theo font hệ thống. Dùng chữ số đồng độ rộng cho hạn mức, số liệu trong bảng và thời điểm đặt lại. Ưu tiên nhịp khoảng cách 4, 8, 12 và 16 px. |
| Điều hướng | Giữ cấu trúc trang và trạng thái thu gọn. Dùng chỉ báo mục đang chọn và thể hiện rõ focus khi điều hướng bàn phím. |
| Form và hộp thoại | Dùng lại nút, ô nhập, dropdown và dialog hiện có. Giữ nhãn, trạng thái disabled, cách đóng và vị trí focus của thành phần. |
| Bảng và thẻ | Căn số liệu nhất quán, giữ cuộn ngang nội bộ tại kích thước hẹp và để tiêu đề dài xuống dòng khi bố cục cho phép. |

Nền tảng được triển khai trong `src/styles/orivanta.css`, nạp sau CSS dùng chung. Kiểm tra các trang ở theme sáng, tối và bảng màu tùy chọn, với điều hướng cổ điển mở/thu gọn và chiều rộng tối thiểu của cửa sổ. Khi mở rộng, ưu tiên chỉnh token và thành phần dùng chung. Thiết kế lại danh sách tài khoản, luồng OAuth, đổi tài khoản và cách tính hạn mức nằm ngoài đợt khởi tạo.
