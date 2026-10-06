import 'package:courtly_auth_starter/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('email hợp lệ và không hợp lệ', () {
    expect(Validators.email('a@gmail.com'), isNull);
    expect(Validators.email('abc'), isNotNull);
    expect(Validators.email(''), isNotNull);
  });

  test('mật khẩu tối thiểu 6 ký tự', () {
    expect(Validators.password('123456'), isNull);
    expect(Validators.password('12345'), isNotNull);
  });

  test('số điện thoại không bắt buộc, nếu nhập thì 10 số bắt đầu bằng 0', () {
    expect(Validators.optionalPhone(''), isNull);
    expect(Validators.optionalPhone('0912345678'), isNull);
    expect(Validators.optionalPhone('912345678'), isNotNull);
  });
}
