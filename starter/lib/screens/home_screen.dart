import 'package:flutter/material.dart';

import '../services/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = auth.user!;
    final scheme = Theme.of(context).colorScheme;
    final initial = user.fullName.isEmpty
        ? '?'
        : user.fullName.substring(0, 1).toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang chủ'),
        actions: [
          IconButton(
            tooltip: 'Đăng xuất',
            icon: const Icon(Icons.logout),
            onPressed: auth.logout,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: scheme.primaryContainer,
              child: Text(
                initial,
                style: TextStyle(fontSize: 32, color: scheme.onPrimaryContainer),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Xin chào, ${user.fullName}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                _row(Icons.email_outlined, 'Email', user.email),
                _row(Icons.phone_outlined, 'Điện thoại', user.phone ?? '(chưa có)'),
                _row(Icons.badge_outlined, 'Vai trò', user.role),
                _row(Icons.login, 'Đăng nhập bằng', user.authProvider),
                _row(Icons.fingerprint, 'ID', user.id),
                _row(Icons.settings_outlined, 'Chế độ', auth.label),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String title, String value) => ListTile(
    leading: Icon(icon),
    title: Text(title),
    subtitle: Text(value),
  );
}
