import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final token = TextEditingController();
  final password = TextEditingController();
  bool submitting = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset password',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Icon(Icons.password, color: AppTheme.hotPink, size: 46),
          const SizedBox(height: 12),
          const Text(
            'Paste your reset token',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
          ),
          const SizedBox(height: 8),
          const Text(
            'In production, deep links can open this page automatically from the email link.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: token,
            decoration: const InputDecoration(labelText: 'Reset token'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'New password'),
          ),
          if (error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: submitting ? null : submit,
            child: Text(submitting ? 'Resetting...' : 'Reset password'),
          ),
        ],
      ),
    );
  }

  Future<void> submit() async {
    setState(() {
      submitting = true;
      error = null;
    });
    try {
      final result = await context.read<AppState>().authService.resetPassword(
        token: token.text.trim(),
        password: password.text,
      );
      context.read<AppState>().setCurrentUser(result.user);
      if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}
