import 'package:flutter/foundation.dart';

import '../models/app_user.dart';
import 'firebase_auth_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Giữ trạng thái đăng nhập cho cả app. main.dart lắng nghe lớp này để chọn
/// màn hình (Splash / Login / Home). Mọi việc nói chuyện với Firebase nằm trong
/// FirebaseAuthService, file này KHÔNG cần sửa.
class AuthController extends ChangeNotifier {
  AuthController(this._service);

  final FirebaseAuthService _service;

  AuthStatus status = AuthStatus.unknown;
  AppUser? user;

  /// Gọi một lần lúc mở app: khôi phục phiên Firebase đã lưu trên máy.
  Future<void> restore() async {
    try {
      user = await _service.restore();
    } catch (_) {
      user = null;
    }
    _update();
  }

  Future<void> login({required String email, required String password}) async {
    user = await _service.signIn(email: email, password: password);
    _update();
  }

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    user = await _service.signUp(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
    );
    _update();
  }

  Future<void> loginWithGoogle() async {
    user = await _service.signInWithGoogle();
    _update();
  }

  Future<void> sendPasswordReset(String email) =>
      _service.sendPasswordReset(email);

  Future<void> logout() async {
    await _service.signOut();
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

/// Đối tượng dùng chung cho cả app.
final AuthController auth = AuthController(FirebaseAuthService());
