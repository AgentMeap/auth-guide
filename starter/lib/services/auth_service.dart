import '../models/app_user.dart';

/// Lỗi xác thực có sẵn thông báo tiếng Việt để hiện thẳng cho người dùng.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Hợp đồng chung. Giao diện KHÔNG gọi lớp này trực tiếp mà đi qua
/// AuthController. Muốn đổi nguồn xác thực chỉ cần đổi lớp cài đặt ở
/// lib/services/auth_provider.dart.
abstract class AuthService {
  /// Tên chế độ, hiện ở màn hình để biết app đang dùng nguồn nào.
  String get label;

  /// Gọi một lần khi mở app: khôi phục phiên đã lưu. Trả về null nếu chưa đăng nhập.
  Future<AppUser?> restore();

  Future<AppUser> login({required String email, required String password});

  Future<AppUser> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  });

  Future<AppUser> loginWithGoogle();

  Future<void> sendPasswordReset(String email);

  Future<void> logout();
}
