import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class LanguageRegionScreen extends StatelessWidget {
  const LanguageRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.language,
      title: 'Language and region',
      subtitle:
          'Set your app language, country, currency, measurement units, and regional shopping preferences.',
      sections: [
        'Language',
        'Country or region',
        'Currency',
        'Size and measurement units',
      ],
    );
  }
}
