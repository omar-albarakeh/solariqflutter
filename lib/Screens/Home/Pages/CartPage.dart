import 'package:flutter/material.dart';

import '../../../Config/AppText.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
      backgroundColor: theme.primaryColor,
      title: const Text(
        'Cart',
        style: AppTextStyles.appBarTitle,
      ),
    ));
  }
}
