# Orivanta

**Personal AI Workspace Manager**

Orivanta là bản tùy biến phi thương mại của **Cockpit Tools** do **jlcodes99** và các cộng tác viên phát triển. Dự án giữ lịch sử Git và kiến trúc React, Tauri và Rust của Cockpit Tools. Orivanta có nhận diện riêng, giao diện mặc định tiếng Việt, hồ sơ ứng dụng riêng và quy trình duyệt cập nhật upstream.

## Phát triển

Sử dụng Node.js 22, npm và Rust stable. Tauri cần bộ công cụ biên dịch và thư viện nền tảng tương ứng. [Điều kiện cài đặt Tauri](https://v2.tauri.app/start/prerequisites/)

```sh
npm ci
npm run typecheck
npm test
node scripts/check_locales.cjs
node --test scripts/custom/*.test.cjs
npm run build
npm run tauri:dev
```

`npm run dev` khởi động frontend tại `http://localhost:1470`. Các thao tác cần Tauri sử dụng `npm run tauri:dev`. Xem [kiến trúc](docs/custom/ARCHITECTURE.md) trước khi thử cài đặt song song. Theo dõi bản phát hành tại [GitHub Releases của Orivanta](https://github.com/TanBuiDev/orivanta/releases).

## Duy trì

- [Kiến trúc và ranh giới dữ liệu](docs/custom/ARCHITECTURE.md)
- [Thiết kế giao diện](docs/custom/UI_DESIGN.md)
- [Hướng dẫn dịch tiếng Việt](docs/custom/TRANSLATION_GUIDE.md)
- [Chính sách cập nhật upstream](docs/custom/UPSTREAM_POLICY.md)
- [Lịch sử đồng bộ](docs/custom/UPSTREAM_HISTORY.md)
- [Chỉ dẫn cho coding agent](AGENTS.md)

## Nguồn gốc và giấy phép

Ghi công **jlcodes99** và các cộng tác viên của Cockpit Tools. Danh sách các dự án bên thứ ba được ghi tại mục Acknowledgments. [Mã nguồn Cockpit Tools](https://github.com/jlcodes99/cockpit-tools) · [README tiếng Anh upstream](README.en.md#acknowledgments) · [README tiếng Trung tại mốc gốc](https://github.com/jlcodes99/cockpit-tools/blob/c004bf71be250cc2536fc91ef90638837f0013a0/README.md)

Các sửa đổi cho Orivanta được phân phối theo **CC BY-NC-SA 4.0**. Giữ ghi công, liên kết giấy phép và thông báo sửa đổi khi chia sẻ. Sử dụng phi thương mại và áp dụng điều khoản chia sẻ tương tự cho bản phái sinh. Liên hệ chủ thể quyền để xin phép riêng nếu cần sử dụng thương mại. [Thông báo giấy phép](LICENSE.md) · [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)
