import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class AccountVerificationScreen extends StatelessWidget {
  const AccountVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.verified_user,
      title: 'Account verification',
      subtitle:
          'Verify identity and seller details to improve marketplace trust and buyer confidence.',
      sections: [
        'Verify email',
        'Verify phone number',
        'Identity document check',
        'Seller badge review',
      ],
    );
  }
}
