# Courtly Auth Demo (project thực hành Firebase)

Project Flutter nhỏ có **Đăng ký, Đăng nhập, Đăng nhập Google**, lưu dữ liệu ở **Firebase** (tài khoản trong Authentication, hồ sơ trong Cloud Firestore). Giao diện đã viết sẵn. Phần gọi Firebase được **cố ý để trống**, bạn sẽ dán từng đoạn code vào đúng chỗ theo trang hướng dẫn (mục B0 và B2b) để hiểu cần những thư viện và dòng code nào.

## Bắt đầu

```bash
git clone https://github.com/<tên-github>/<tên-repo>.git
cd <tên-repo>/starter

# Sinh thư mục android/ (repo không chứa sẵn). Đổi com.tenban thành tên của bạn:
flutter create --platforms=android --org com.tenban .
```

> Nếu `lib/main.dart` bị thay bằng app đếm số mẫu (hiếm gặp), chạy `git checkout lib/main.dart`.

Rồi làm theo **trang hướng dẫn** (GitHub Pages của repo này). Project chưa biên dịch được cho tới khi dán xong các đoạn code, đó là chủ ý.

## 15 chỗ cần dán

Tìm `TODO(PASTE` trong Android Studio (Ctrl + Shift + F) để thấy tất cả.

| Vị trí | File | Nội dung |
|---|---|---|
| PASTE-1 | `pubspec.yaml` | Thêm thư viện Firebase |
| PASTE-2 | `android/app/src/main/AndroidManifest.xml` | Quyền INTERNET |
| PASTE-3 | `android/settings.gradle.kts` | Khai báo plugin Google Services |
| PASTE-4 | `android/app/build.gradle.kts` | Bật plugin Google Services |
| PASTE-5, 6 | `lib/main.dart` | Import và khởi tạo Firebase |
| PASTE-7 | `lib/services/firebase_auth_service.dart` | Web client ID cho Google |
| PASTE-8 | `lib/services/firebase_auth_service.dart` | Khôi phục phiên đăng nhập |
| PASTE-9 | `lib/services/firebase_auth_service.dart` | Đăng ký |
| PASTE-10 | `lib/services/firebase_auth_service.dart` | Đăng nhập email và mật khẩu |
| PASTE-11 | `lib/services/firebase_auth_service.dart` | Đăng nhập Google |
| PASTE-12 | `lib/services/firebase_auth_service.dart` | Quên mật khẩu |
| PASTE-13 | `lib/services/firebase_auth_service.dart` | Đăng xuất |
| PASTE-14 | `lib/services/firebase_auth_service.dart` | Ghi hồ sơ lên Firestore |
| PASTE-15 | `lib/services/firebase_auth_service.dart` | Đọc hồ sơ từ Firestore |

Ngoài code, còn phải làm trên Firebase Console: bật Email/Password và Google, tạo Firestore, dán `firestore.rules`, thêm SHA-1 và tải `google-services.json` (xem B1, B2 trong trang hướng dẫn).

## Cấu trúc

```
lib/
  main.dart                      chọn màn hình theo trạng thái đăng nhập   (PASTE-5, 6)
  models/app_user.dart           người dùng
  services/
    firebase_auth_service.dart   mọi lệnh gọi Firebase                     (PASTE-7 đến 15)
    auth_controller.dart         giữ trạng thái đăng nhập, đã viết sẵn
    auth_exception.dart          lỗi có thông báo tiếng Việt
  screens/                       Login, Register, Home (đã viết sẵn)
  utils/validators.dart
firestore.rules                  Security Rules để dán vào Firebase Console
snippets/                        BẢN ĐÃ DÁN XONG, để đối chiếu khi bí (*.txt)
```

## Đối chiếu khi bí

`snippets/firebase_auth_service.dart.txt`, `snippets/main.dart.txt`, `snippets/pubspec.yaml.txt` là các file sau khi dán đủ. Đuôi `.txt` để Flutter không biên dịch chúng.

## Đừng commit file bí mật

`google-services.json` đã nằm trong `.gitignore` của project này. Mỗi người tự tải file của project Firebase mình.
