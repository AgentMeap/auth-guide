import '../models/app_user.dart';
import 'auth_service.dart';

/// Bản giả lập chạy trong bộ nhớ, để app chạy được TRƯỚC khi tích hợp Firebase.
/// Tài khoản có sẵn: demo@courtly.vn / 123456. Tắt app là mất dữ liệu.
class FakeAuthService implements AuthService {
  final Map<String, _Account> _accounts = {
    'demo@courtly.vn': const _Account(
      password: '123456',
      user: AppUser(
        id: 'fake-1',
        fullName: 'Người dùng demo',
        email: 'demo@courtly.vn',
      ),
    ),
  };

  static const _latency = Duration(milliseconds: 600);

  @override
  String get label => 'Giả lập (chưa dùng Firebase)';

  @override
  Future<AppUser?> restore() async => null;

  @override
  Future<AppUser> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_latency);
    final account = _accounts[email.trim().toLowerCase()];
    if (account == null || account.password != password) {
      throw const AuthException('Email hoặc mật khẩu không đúng.');
    }
    return account.user;
  }

  @override
  Future<AppUser> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    await Future<void>.delayed(_latency);
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) {
      throw const AuthException('Email này đã được đăng ký.');
    }
    final user = AppUser(
      id: 'fake-${_accounts.length + 1}',
      fullName: fullName.trim(),
      email: key,
      phone: phone,
    );
    _accounts[key] = _Account(password: password, user: user);
    return user;
  }

  @override
  Future<AppUser> loginWithGoogle() async {
    throw const AuthException(
      'Chưa tích hợp Firebase nên chưa có đăng nhập Google. '
      'Hãy làm theo hướng dẫn để thay FakeAuthService bằng FirebaseAuthService.',
    );
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await Future<void>.delayed(_latency);
  }

  @override
  Future<void> logout() async {}
}

class _Account {
  const _Account({required this.password, required this.user});

  final String password;
  final AppUser user;
}
