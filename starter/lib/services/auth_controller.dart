import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import 'auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Giữ trạng thái đăng nhập cho cả app. main.dart lắng nghe lớp này để chọn
/// màn hình (Splash / Login / Home). Bạn không cần sửa file này khi tích hợp Firebase.
class AuthController extends ChangeNotifier {
  AuthController(this._service);

  final AuthService _service;

  AuthStatus status = AuthStatus.unknown;
  AppUser? user;

  String get label => _service.label;

  /// Gọi một lần lúc mở app.
  Future<void> restore() async {
    try {
      user = await _service.restore();
    } catch (_) {
      user = null;
    }
    _update();
  }

  Future<void> login({required String email, required String password}) async {
    user = await _service.login(email: email, password: password);
    _update();
  }

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    user = await _service.signup(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
    _update();
  }

  Future<void> loginWithGoogle() async {
    user = await _service.loginWithGoogle();
    _update();
  }

  Future<void> sendPasswordReset(String email) =>
      _service.sendPasswordReset(email);

  Future<void> logout() async {
    await _service.logout();
    user = null;
    _update();
  }

  void _update() {
    status = user == null
        ? AuthStatus.unauthenticated
        : AuthStatus.authenticated;
    notifyListeners();
  }
}
