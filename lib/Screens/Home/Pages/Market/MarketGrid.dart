import 'package:flutter/material.dart';

import 'MarketItem.dart';
import 'MarketItemModel.dart';

class MarketGrid extends StatelessWidget {
  final List<MarketItemModel> items;

  MarketGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2 / 3,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return MarketItem(item: item);
      },
    );
  }
}
