import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/auth/auth_api.dart';
import '../../core/auth/auth_state.dart';
import '../../core/auth/auth_storage.dart';
import '../../core/api/api_client.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _first = TextEditingController();
  final _last = TextEditingController();
  String? _gender;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _first.dispose();
    _last.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_password.text != _confirm.text) {
      setState(() => _error = 'Passwords do not match');
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await AuthApi.register(
        email: _email.text.trim(),
        password: _password.text,
        firstName: _first.text.trim().isEmpty ? null : _first.text.trim(),
        lastName: _last.text.trim().isEmpty ? null : _last.text.trim(),
        gender: _gender,
      );
      final token = data['token'] as String;
      await AuthStorage.saveToken(token);
      ApiClient.setAuthToken(token);
      ref.read(authStateProvider.notifier).setAuthenticated(token);
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      String message = 'Sign up failed';
      if (e is DioException) {
        final status = e.response?.statusCode;
        if (status == 409) {
          message = 'Email already in use';
        } else if (e.response?.data is Map &&
            (e.response?.data['error'] is String)) {
          message = e.response?.data['error'];
        }
      }
      setState(() => _error = message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _first,
              decoration: const InputDecoration(labelText: 'First name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _last,
              decoration: const InputDecoration(labelText: 'Last name'),
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
            TextField(
              controller: _confirm,
              decoration: const InputDecoration(labelText: 'Confirm password'),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _gender,
              onChanged: (val) => setState(() => _gender = val),
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('Create account'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.go('/auth/sign-in'),
              child: const Text('Have an account? Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
