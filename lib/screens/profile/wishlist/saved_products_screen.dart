import 'package:flutter/material.dart';

import '../common/info_page.dart';

class SavedProductsScreen extends StatelessWidget {
  const SavedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.favorite_border,
      title: 'Saved products',
      subtitle:
          'Products you favorite will appear here so you can compare prices and revisit them later.',
      sections: [
        'Saved product grid',
        'Price drop alerts',
        'Back-in-stock alerts',
      ],
    );
  }
}
