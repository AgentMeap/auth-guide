# Courtly Auth Starter

Dự án Flutter **rất nhỏ** để thực hành tích hợp **Firebase Authentication + Google Sign-In + Firestore** (môn PRM393).
Clone về, chạy được ngay bằng dữ liệu giả, rồi làm theo trang hướng dẫn để **dán code Firebase vào**. Đích đến: đăng ký, đăng nhập, quên mật khẩu và Google chạy bằng Firebase thật.

## Cách dùng

```bash
git clone https://github.com/<tên-github>/<tên-repo>.git
cd <tên-repo>/starter

# Sinh thư mục android/ (repo không chứa sẵn). Đổi com.tenban thành tên của bạn:
flutter create --platforms=android --org com.tenban .
flutter pub get
flutter run
```

> Nếu `lib/main.dart` bị thay bằng app đếm số mẫu (hiếm gặp), chạy `git checkout lib/main.dart`.

App mở lên ở **chế độ giả lập**: đăng nhập `demo@courtly.vn` / `123456`, hoặc đăng ký tài khoản mới (mất khi tắt app). Nút Google báo "chưa tích hợp" là đúng.

Sau đó làm tiếp phần **B0 → B3** của trang hướng dẫn (mục "Dự án mẫu"):

| Bước | Việc | Nơi sửa |
|---|---|---|
| 1 | Thêm thư viện Firebase | `flutter pub add ...` |
| 2 | Cấu hình Android (INTERNET, plugin google-services) | `android/...` |
| 3 | Tạo project Firebase, bật Email/Password + Google, tạo Firestore, dán Rules | Firebase Console |
| 4 | Dán 2 đoạn code khởi tạo Firebase | `lib/main.dart` |
| 5 | Dán file `firebase_auth_service.dart` và đổi 1 dòng | `lib/services/` |
| 6 | Thêm SHA-1, tải `google-services.json`, điền Web client ID | Firebase Console, `android/app/` |

Các đoạn code cần dán nằm trong thư mục `snippets/` (đuôi `.txt` để trình phân tích của Flutter không biên dịch chúng trước khi bạn sẵn sàng). Chúng cũng có sẵn, kèm nút "Sao chép", trong trang hướng dẫn.

## Cấu trúc

```
lib/
  main.dart                      chọn màn hình theo trạng thái đăng nhập   (sửa ở bước 4)
  models/app_user.dart           người dùng
  services/
    auth_service.dart            hợp đồng chung (AuthService) + AuthException
    fake_auth_service.dart       bản giả lập, chạy ngay không cần Firebase
    auth_controller.dart         giữ trạng thái đăng nhập (ChangeNotifier)
    auth_provider.dart           DUY NHẤT chỗ chọn nguồn xác thực           (sửa ở bước 5)
    firebase_auth_service.dart   (bạn tạo ở bước 5 từ snippets/)
  screens/                       Login, Register, Home
  utils/validators.dart
firestore.rules                  Security Rules để dán vào Firebase Console
snippets/                        code cần dán
```

Ý tưởng: giao diện chỉ biết `AuthController`; `AuthController` chỉ biết `AuthService`. Muốn đổi sang Firebase chỉ cần cài đặt một lớp mới `FirebaseAuthService` và đổi một dòng ở `auth_provider.dart`. Không phải sửa màn hình nào.

## Đừng commit file bí mật

`google-services.json` đã nằm trong `.gitignore` của dự án này. Mỗi người tự tải file của project Firebase mình.
