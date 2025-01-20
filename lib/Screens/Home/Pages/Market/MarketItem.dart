import 'package:flutter/material.dart';

import 'MarketItemModel.dart';

class MarketItem extends StatelessWidget {
  final MarketItemModel item;

  MarketItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$${item.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to item details page
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),
                    child: Text('Details',
                        style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: FloatingActionButton(
              onPressed: () {
                // Add to cart logic
              },
              backgroundColor: Colors.green,
              mini: true,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
