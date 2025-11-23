import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_api.dart';
import '../../core/auth/auth_state.dart';
import '../../core/auth/auth_storage.dart';
import '../../core/api/api_client.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
      ApiClient.setAuthToken(token);
      ref.read(authStateProvider.notifier).setAuthenticated(token);
      if (!mounted) return;
      context.go('/home');
    } catch (_) {
      setState(() => _error = 'Login failed');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Sign in'),
            ),
            TextButton(
              onPressed: () => context.go('/auth/reset'),
              child: const Text('Forgot password?'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.go('/auth/sign-up'),
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
