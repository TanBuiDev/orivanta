# Hướng dẫn bản địa hóa tiếng Việt

Orivanta dùng tiếng Việt cho hồ sơ mới. React dùng `react-i18next` với tiếng Anh dự phòng. `src/locales/vi.json` là dữ liệu upstream. `src/i18n/orivanta/vi.json` bổ sung các bản dịch của Orivanta, và `src/i18n/orivanta/en.json` chứa văn bản nhận diện tiếng Anh. `src/i18n/index.ts` nạp lớp tùy biến sau khi nạp tài nguyên ngôn ngữ. Các khóa hiện có của cả hai ngôn ngữ được giữ nguyên.

| Khái niệm | Thuật ngữ |
| --- | --- |
| Account / Switch account | Tài khoản / Chuyển tài khoản |
| Quota / Remaining quota | Hạn mức / Hạn mức còn lại |
| Refresh / Reset | Làm mới / Đặt lại |
| OAuth authorization | Ủy quyền OAuth |
| API key / Token | Khóa API / token |
| Provider / API relay | Nhà cung cấp / Chuyển tiếp API |
| Release notes | Ghi chú phát hành |

- Dùng `t(...)` trong React. Thêm hoặc đổi giá trị ở JSON. Giữ chính xác `{{error}}`, `{{count}}` và các biến khác, kể cả chữ hoa/thường. Duy trì các khóa số nhiều của i18next và ngữ cảnh kỹ thuật.
- Giữ tên nhà cung cấp, tên lệnh, mã lỗi, trường JSON và tên định dạng trao đổi theo nguyên bản. Lỗi mô tả nguyên nhân hoặc bước xử lý có thể thực hiện. Thông báo ngắn dùng dấu ba chấm Unicode cho thao tác đang diễn ra.
- `node scripts/check_locales.cjs` kiểm tra các bộ khóa và tham chiếu. `node --test scripts/custom/*.test.cjs` xác minh lớp tùy biến chỉ dùng khóa hợp lệ và giữ biến nội suy.
- Kiểm tra menu, form, lỗi, hộp thoại, trang Cài đặt, danh sách tài khoản và hạn mức với tiếng Việt và tiếng Anh. Kiểm tra chiều rộng hẹp, dấu tiếng Việt, số và thời gian. Lỗi khởi động trước khi React hoạt động dùng văn bản dự phòng trong `index.html`.

Đợt khởi tạo ưu tiên văn bản dùng chung và các luồng quản lý tài khoản, OAuth, hạn mức, lỗi mạng và trang Giới thiệu. Phần còn lại dùng bản dịch upstream. Đối chiếu thuật ngữ chuyên biệt của từng nhà cung cấp khi sửa màn hình tương ứng.
