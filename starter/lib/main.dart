import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/auth_controller.dart';
import 'services/auth_provider.dart';
// >>> BƯỚC 4a (Firebase): dán dòng import firebase_core ở đây

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // >>> BƯỚC 4b (Firebase): dán dòng khởi tạo Firebase ở đây
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    auth.restore(); // khôi phục phiên đã lưu (nếu có)
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: auth,
      builder: (context, _) => MaterialApp(
        title: 'Courtly Auth Starter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF0F766E),
          useMaterial3: true,
        ),
        // Chọn màn hình theo trạng thái đăng nhập. Dùng `home:` thay vì
        // Navigator.push để người dùng không bấm Back quay lại màn đăng nhập.
        home: switch (auth.status) {
          AuthStatus.unknown => const _Splash(),
          AuthStatus.unauthenticated => const LoginScreen(),
          AuthStatus.authenticated => const HomeScreen(),
        },
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
