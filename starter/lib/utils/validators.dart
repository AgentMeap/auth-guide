/// Các hàm dùng cho `TextFormField.validator`: trả về null khi hợp lệ,
/// ngược lại trả về thông báo lỗi.
abstract final class Validators {
  static final _email = RegExp(
    r'^[\w.+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
  );
  static final _phone = RegExp(r'^0\d{9}$');

  static String? email(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Vui lòng nhập email';
    return _email.hasMatch(input) ? null : 'Email không đúng định dạng';
  }

  /// Firebase yêu cầu mật khẩu tối thiểu 6 ký tự.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu';
    if (value.length < 6) return 'Mật khẩu tối thiểu 6 ký tự';
    return null;
  }

  static String? fullName(String? value) {
    if ((value ?? '').trim().length < 2) return 'Vui lòng nhập họ tên';
    return null;
  }

  /// Số điện thoại không bắt buộc; nếu nhập thì phải đúng 10 số, bắt đầu bằng 0.
  static String? optionalPhone(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return null;
    return _phone.hasMatch(input)
        ? null
        : 'Số điện thoại gồm 10 chữ số, bắt đầu bằng 0';
  }
}
