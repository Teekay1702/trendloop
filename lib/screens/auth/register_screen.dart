import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import 'verify_email_screen.dart';

class RegisterScreen extends StatefulWidget {
  final bool popOnSuccess;

  const RegisterScreen({super.key, this.popOnSuccess = true});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final shopName = TextEditingController();
  final bio = TextEditingController();
  bool becomeSeller = true;
  bool submitting = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create account',
          style: TextStyle(fontWeight: FontWeight.w900),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.storefront, color: AppTheme.hotPink, size: 42),
                  SizedBox(height: 14),
                  Text(
                    'Join the marketplace',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Create a buyer account or open your P2P seller shop immediately.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            TextFormField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Full name'),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 12),
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
              child: Text(submitting ? 'Please wait...' : 'Create account'),
            ),
            TextButton(
              onPressed: submitting ? null : () => Navigator.pop(context),
              child: const Text('Already have an account? Sign in'),
            ),
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
      await state.register(
        name: name.text.trim(),
        email: email.text.trim(),
        password: password.text,
        becomeSeller: becomeSeller,
        shopName: shopName.text.trim().isEmpty ? null : shopName.text.trim(),
        bio: bio.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created. Please verify your email.'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const VerifyEmailScreen()),
        );
      }
    } catch (e) {
      setState(() => error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}
