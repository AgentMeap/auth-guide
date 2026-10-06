import 'auth_controller.dart';
import 'fake_auth_service.dart';

/// Điểm DUY NHẤT chọn nguồn xác thực của cả app.
///
/// BƯỚC 5 trong hướng dẫn: sau khi dán file firebase_auth_service.dart,
/// đổi dòng bên dưới thành:
///     final AuthController auth = AuthController(FirebaseAuthService());
/// và thêm dòng import tương ứng ở đầu file.
final AuthController auth = AuthController(FakeAuthService());
