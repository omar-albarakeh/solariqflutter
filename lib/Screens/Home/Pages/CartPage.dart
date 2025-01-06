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
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCartItem(),
          ],
        ),
      ),);
  }
}



Widget buildCartItem() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(16.0),
    ),
    padding: EdgeInsets.all(16.0),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.grey,
        ),
        SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trina panel',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text('\$81'),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
          },
        ),
      ],
    ),
  );
}