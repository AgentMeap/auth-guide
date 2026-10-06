import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import '../models/app_user.dart';
import 'auth_exception.dart';

// TODO(PASTE-7): dán Web client ID của bạn, thay cho dòng const bên dưới
const String googleServerClientId = 'CHUA-DIEN';

/// Toàn bộ phần nói chuyện với Firebase nằm ở đây:
///  - Firebase Authentication: đăng ký, đăng nhập, Google, quên mật khẩu
///  - Cloud Firestore: lưu hồ sơ người dùng ở users/{uid}
///
/// Các chỗ có `TODO(PASTE-n)` đang để trống. Làm theo trang hướng dẫn để dán
/// code vào đúng chỗ. Phần còn lại (xử lý lỗi, chuyển dữ liệu) đã viết sẵn.
class FirebaseAuthService {
  fb.FirebaseAuth get _auth => fb.FirebaseAuth.instance;
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  static const _users = 'users';
  bool _googleReady = false;

  // ---- Khôi phục phiên khi mở app -----------------------------------------

  Future<AppUser?> restore() => _guard(() async {
    // TODO(PASTE-8): khôi phục phiên đăng nhập. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-8: restore');
  });

  // ---- Email + mật khẩu ----------------------------------------------------

  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) => _guard(() async {
    // TODO(PASTE-9): đăng ký tài khoản. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-9: signUp');
  });

  Future<AppUser> signIn({
    required String email,
    required String password,
  }) => _guard(() async {
    // TODO(PASTE-10): đăng nhập bằng email + mật khẩu. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-10: signIn');
  });

  Future<void> sendPasswordReset(String email) => _guard(() async {
    // TODO(PASTE-12): gửi email đặt lại mật khẩu. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-12: sendPasswordReset');
  });

  // ---- Google --------------------------------------------------------------

  Future<AppUser> signInWithGoogle() => _guard(() async {
    // TODO(PASTE-11): đăng nhập Google. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-11: signInWithGoogle');
  });

  // ---- Đăng xuất -----------------------------------------------------------

  Future<void> signOut() async {
    try {
      // TODO(PASTE-13): đăng xuất Firebase và Google. Dán code vào đây.
    } catch (_) {
      // Đăng xuất phía máy khách vẫn tiếp tục.
    }
  }

  // ---- Hồ sơ người dùng trong Firestore -----------------------------------

  /// Ghi hồ sơ lên Firestore: users/{uid}. Trả về hồ sơ vừa ghi.
  Future<AppUser> _saveProfile(
    fb.User user, {
    required String? fullName,
    required String? phone,
  }) async {
    // TODO(PASTE-14): ghi hồ sơ lên Firestore. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-14: _saveProfile');
  }

  /// Đọc hồ sơ từ Firestore. Trả về null nếu chưa có.
  Future<AppUser?> _loadProfile(fb.User user) async {
    // TODO(PASTE-15): đọc hồ sơ từ Firestore. Xoá dòng throw rồi dán code vào đây.
    throw UnimplementedError('PASTE-15: _loadProfile');
  }

  // ---- Phần đã viết sẵn (không cần sửa) -----------------------------------

  /// Có hồ sơ thì dùng, chưa có (Google lần đầu, hoặc đăng ký từng dở dang) thì tạo.
  Future<AppUser> _loadOrCreateProfile(fb.User user) async {
    final existing = await _loadProfile(user);
    if (existing != null) return existing;
    return _saveProfile(user, fullName: user.displayName, phone: null);
  }

  AppUser _fromData(fb.User user, Map<String, dynamic> data) => AppUser(
    id: user.uid,
    fullName: (data['fullName'] as String?) ?? user.displayName ?? '',
    email: (data['email'] as String?) ?? user.email ?? '',
    phone: data['phone'] as String?,
    role: (data['role'] as String?) ?? 'CUSTOMER',
    authProvider: (data['authProvider'] as String?) ?? _providerOf(user),
  );

  String _providerOf(fb.User user) =>
      user.providerData.any((info) => info.providerId == 'google.com')
      ? 'GOOGLE'
      : 'LOCAL';

  /// Đổi mọi lỗi của Firebase thành AuthException có thông báo tiếng Việt.
  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on AuthException {
      rethrow;
    } on fb.FirebaseAuthException catch (error) {
      throw AuthException(_authMessage(error.code));
    } on FirebaseException catch (error) {
      throw AuthException(_firestoreMessage(error.code));
    }
  }

  String _authMessage(String code) => switch (code) {
    'invalid-credential' ||
    'invalid-login-credentials' ||
    'wrong-password' ||
    'user-not-found' => 'Email hoặc mật khẩu không đúng.',
    'invalid-email' => 'Email không hợp lệ.',
    'email-already-in-use' => 'Email này đã được đăng ký.',
    'weak-password' => 'Mật khẩu quá yếu (tối thiểu 6 ký tự).',
    'user-disabled' => 'Tài khoản đã bị khoá.',
    'too-many-requests' => 'Bạn thao tác quá nhanh, vui lòng thử lại sau.',
    'network-request-failed' => 'Không thể kết nối mạng.',
    'operation-not-allowed' =>
      'Chưa bật đăng nhập Email/Password trong Firebase Console.',
    _ => 'Firebase báo lỗi ($code).',
  };

  String _firestoreMessage(String code) => switch (code) {
    'no-app' =>
      'Firebase chưa được khởi tạo. Kiểm tra PASTE-6 (Firebase.initializeApp) '
          'và file google-services.json.',
    'permission-denied' =>
      'Firestore từ chối quyền truy cập. Hãy dán và Publish firestore.rules.',
    'unavailable' || 'deadline-exceeded' => 'Không thể kết nối mạng.',
    'not-found' ||
    'failed-precondition' => 'Chưa tạo Firestore Database trong Firebase Console.',
    _ => 'Firestore báo lỗi ($code).',
  };
}
