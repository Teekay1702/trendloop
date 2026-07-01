import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'buyer/buyer_shell.dart';
import 'seller/seller_shell.dart';

class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    final isSeller = context.watch<AppState>().isSeller;
    return isSeller ? const SellerShell() : const BuyerShell();
  }
}
