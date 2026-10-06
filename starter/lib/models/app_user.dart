/// Người dùng đang đăng nhập. Hồ sơ này được lưu ở Firestore: users/{uid}.
class AppUser {
  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.role = 'CUSTOMER',
    this.authProvider = 'LOCAL',
  });

  final String id;
  final String fullName;
  final String email;
  final String? phone;

  /// CUSTOMER hoặc ADMIN.
  final String role;

  /// LOCAL (email + mật khẩu) hoặc GOOGLE.
  final String authProvider;

  bool get isAdmin => role == 'ADMIN';
}
