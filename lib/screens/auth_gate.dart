import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'auth_screen.dart';
import 'root_shell.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AppState>().isLoggedIn;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: isLoggedIn
          ? const RootShell(key: ValueKey('app'))
          : const AuthScreen(key: ValueKey('auth'), popOnSuccess: false),
    );
  }
}
