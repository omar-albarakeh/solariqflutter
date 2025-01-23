// import 'package:flutter/material.dart';
// import '../Pages/Market/MarketItem.dart';
// import 'itemModule.dart';
//
// class MarketGrid extends StatelessWidget {
//   final List<Item> items;
//
//   MarketGrid({required this.items});
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: EdgeInsets.all(8.0),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         final item = items[index];
//         return MarketItem(item: item);
//       },
//     );
//   }
// }