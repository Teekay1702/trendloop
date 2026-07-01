import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final token = TextEditingController();
  bool submitting = false;
  String? message;
  String? error;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: AppTheme.blush, borderRadius: BorderRadius.circular(26)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.mark_email_read, color: AppTheme.hotPink, size: 42),
              const SizedBox(height: 12),
              Text(user?.emailVerified == true ? 'Email verified' : 'Verify your email', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
              const SizedBox(height: 8),
              Text(user?.emailVerified == true ? 'Your email is verified.' : 'Check your inbox for the verification link. You can also paste the token here.'),
            ]),
          ),
          const SizedBox(height: 16),
          TextField(controller: token, decoration: const InputDecoration(labelText: 'Verification token')),
          if (message != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(message!, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w800))),
          if (error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(error!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w800))),
          const SizedBox(height: 18),
          FilledButton(onPressed: submitting ? null : verify, child: Text(submitting ? 'Verifying...' : 'Verify email')),
          TextButton(onPressed: submitting ? null : resend, child: const Text('Resend verification email')),
        ],
      ),
    );
  }

  Future<void> verify() async {
    setState(() { submitting = true; error = null; message = null; });
    try {
      final result = await context.read<AppState>().authService.verifyEmail(token.text.trim());
      context.read<AppState>().setCurrentUser(result.user);
      setState(() => message = result.message ?? 'Email verified');
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }

  Future<void> resend() async {
    setState(() { submitting = true; error = null; message = null; });
    try {
      final result = await context.read<AppState>().authService.resendVerificationEmail();
      setState(() => message = result);
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}
