import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final TextEditingController codeController = TextEditingController();

  bool submitting = false;
  String? message;
  String? error;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Email',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.blush,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.mark_email_read_rounded,
                  size: 46,
                  color: AppTheme.hotPink,
                ),
                const SizedBox(height: 14),
                Text(
                  user?.emailVerified == true
                      ? 'Email Verified'
                      : 'Verify Your Email',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.emailVerified == true
                      ? 'Your email has already been verified. You now have full access to your TrendLoop account.'
                      : 'We\'ve sent a 6-digit verification code to:\n\n${user?.email ?? ""}\n\nEnter the code below to verify your account.',
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          Pinput(
            controller: codeController,
            enabled: !submitting && user?.emailVerified != true,
            keyboardType: TextInputType.number,
            length: 6,
            onChanged: (_) => setState(() {}),
            onCompleted: (_) => verify(),
          ),

          if (message != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message!,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (error != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      error!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 28),

          FilledButton(
            onPressed:
                submitting ||
                    user?.emailVerified == true ||
                    codeController.text.trim().length != 6
                ? null
                : verify,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            child: Text(submitting ? 'Verifying...' : 'Verify Email'),
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: submitting || user?.emailVerified == true
                ? null
                : resend,
            child: const Text("Resend Verification Code"),
          ),
        ],
      ),
    );
  }

  Future<void> verify() async {
    final code = codeController.text.trim();

    if (code.length != 6) {
      setState(() {
        error = 'Please enter the 6-digit verification code.';
      });
      return;
    }

    setState(() {
      submitting = true;
      error = null;
      message = null;
    });

    try {
      final result = await context.read<AppState>().authService.verifyEmail(
        code,
      );

      context.read<AppState>().setCurrentUser(result.user);

      codeController.clear();

      setState(() {
        message = result.message ?? 'Email verified successfully.';
      });
    } catch (e) {
      setState(() {
        error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => submitting = false);
      }
    }
  }

  Future<void> resend() async {
    setState(() {
      submitting = true;
      error = null;
      message = null;
    });

    try {
      final result = await context
          .read<AppState>()
          .authService
          .resendVerificationEmail();

      setState(() {
        message = result;
      });
    } catch (e) {
      setState(() {
        error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() => submitting = false);
      }
    }
  }
}
