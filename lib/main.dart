import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/auth_gate.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const TrendLoopApp());
}

class TrendLoopApp extends StatelessWidget {
  const TrendLoopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..loadProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TrendLoop',
        theme: AppTheme.light,
        home: const AuthGate(),
      ),
    );
  }
}
