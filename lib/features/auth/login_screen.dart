import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/auth/auth_api.dart';
import '../../core/auth/auth_state.dart';
import '../../core/auth/auth_storage.dart';
import '../root/app_routes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await AuthApi.login(
        email: _email.text.trim(),
        password: _password.text,
      );
      final token = data['token'] as String;
      await AuthStorage.saveToken(token);
      ref.read(authStateProvider.notifier).setAuthenticated(token);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      setState(() => _error = 'Login failed');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Login'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.signup),
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
