import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class SavedStoresScreen extends StatelessWidget {
  const SavedStoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.storefront_outlined,
      title: 'Saved stores',
      subtitle:
          'Follow your favorite seller stores and see their newest drops in one place.',
      sections: [
        'Followed stores',
        'New drop notifications',
        'Recommended similar stores',
      ],
    );
  }
}
