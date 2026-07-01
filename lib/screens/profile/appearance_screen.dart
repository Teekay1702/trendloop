import 'package:flutter/material.dart';

import '../common/info_page.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.palette,
      title: 'Appearance',
      subtitle:
          'Customize theme, display density, product image preferences, and app visuals.',
      sections: [
        'Light and dark mode',
        'Display density',
        'Image quality',
        'Accessibility preferences',
      ],
    );
  }
}
