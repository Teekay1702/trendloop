import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.location_on,
      title: 'Addresses',
      subtitle:
          'Manage shipping addresses for purchases and return addresses for seller shipments.',
      sections: [
        'Default shipping address',
        'Add new address',
        'Return address',
        'Delivery instructions',
      ],
    );
  }
}
