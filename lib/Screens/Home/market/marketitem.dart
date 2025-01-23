import 'package:flutter/material.dart';
import 'itemModule.dart'; // Ensure this import is correct

class MarketItem extends StatelessWidget {
  final Item item; // Change the type to `Item`

  MarketItem({required this.item}); // Update the constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Image.network(item.imageUrl ?? 'https://example.com/default.jpg'),
          Text(item.name ?? 'Unknown'),
          Text('\$${item.price}'),
        ],
      ),
    );
  }
}