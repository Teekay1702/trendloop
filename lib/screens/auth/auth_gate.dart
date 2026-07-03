import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../splash_screen.dart';
import 'login_screen.dart';
import 'verify_email_screen.dart';
import '../root_shell.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _loadSplash();
  }

  Future<void> _loadSplash() async {
    // Keep splash screen on for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _showSplash = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashScreen();
    }

    final state = context.watch<AppState>();
    final isLoggedIn = state.isLoggedIn;
    final isVerified = state.currentUser?.emailVerified ?? false;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: () {
        if (!isLoggedIn) {
          return const LoginScreen(key: ValueKey('login'), popOnSuccess: false);
        }

        if (!isVerified) {
          return const VerifyEmailScreen(key: ValueKey('verify'));
        }

        return const RootShell(key: ValueKey('app'));
      }(),
    );
  }
}
