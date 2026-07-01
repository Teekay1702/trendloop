import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'forgot_password_screen.dart';
import 'verify_email_screen.dart';

class AuthScreen extends StatefulWidget {
  final bool popOnSuccess;

  const AuthScreen({super.key, this.popOnSuccess = true});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController(text: 'mia@example.com');
  final password = TextEditingController(text: 'password123');
  final shopName = TextEditingController();
  final bio = TextEditingController();
  bool isRegister = false;
  bool becomeSeller = true;
  bool submitting = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isRegister ? 'Create account' : 'Sign in',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [AppTheme.ink, Color(0xFF4B1732)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.storefront,
                    color: AppTheme.hotPink,
                    size: 42,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    isRegister ? 'Join the marketplace' : 'Welcome back',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isRegister
                        ? 'Create a buyer account or open your P2P seller shop immediately.'
                        : 'Sign in to buy, sell, list products, and save your cart.',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            if (isRegister) ...[
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 12),
            ],
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (v) => v == null || !v.contains('@')
                  ? 'Valid email is required'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (v) => v == null || v.length < 8
                  ? 'Use at least 8 characters'
                  : null,
            ),
            if (isRegister) ...[
              const SizedBox(height: 14),
              SwitchListTile.adaptive(
                value: becomeSeller,
                onChanged: (v) => setState(() => becomeSeller = v),
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                title: const Text(
                  'Also create my seller shop',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: const Text(
                  'You can start listing products after signup.',
                ),
              ),
              if (becomeSeller) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: shopName,
                  decoration: const InputDecoration(labelText: 'Shop name'),
                  validator: (v) =>
                      becomeSeller && (v == null || v.trim().isEmpty)
                      ? 'Shop name is required'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: bio,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Shop bio'),
                ),
              ],
            ],
            if (error != null) ...[
              const SizedBox(height: 12),
              Text(
                error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            const SizedBox(height: 22),
            FilledButton(
              onPressed: submitting ? null : submit,
              child: Text(
                submitting
                    ? 'Please wait...'
                    : isRegister
                    ? 'Create account'
                    : 'Sign in',
              ),
            ),
            TextButton(
              onPressed: submitting
                  ? null
                  : () => setState(() {
                      isRegister = !isRegister;
                      error = null;
                      if (isRegister && email.text == 'mia@example.com')
                        email.clear();
                      if (isRegister && password.text == 'password123')
                        password.clear();
                    }),
              child: Text(
                isRegister
                    ? 'Already have an account? Sign in'
                    : 'New here? Create an account',
              ),
            ),
            if (!isRegister) ...[
              TextButton(
                onPressed: submitting
                    ? null
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      ),
                child: const Text('Forgot password?'),
              ),
              TextButton.icon(
                onPressed: submitting
                    ? null
                    : () async {
                        email.text = 'mia@example.com';
                        password.text = 'password123';
                        await submit();
                      },
                icon: const Icon(Icons.bolt),
                label: const Text('Use demo seller account'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      submitting = true;
      error = null;
    });
    final state = context.read<AppState>();
    try {
      if (isRegister) {
        await state.register(
          name: name.text.trim(),
          email: email.text.trim(),
          password: password.text,
          becomeSeller: becomeSeller,
          shopName: shopName.text.trim().isEmpty ? null : shopName.text.trim(),
          bio: bio.text.trim(),
        );
      } else {
        await state.login(email.text.trim(), password.text);
      }
      if (mounted && isRegister) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created. Please verify your email.'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VerifyEmailScreen()),
        );
      }
      if (mounted && widget.popOnSuccess && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}
