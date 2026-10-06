/// Lỗi xác thực có sẵn thông báo tiếng Việt để hiện thẳng cho người dùng.
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
