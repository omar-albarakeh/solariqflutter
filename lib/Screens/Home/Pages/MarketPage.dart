import 'package:flutter/material.dart';

import 'CartPage.dart';
import 'MarketGrid.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
          title: Text('Market'),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Inverters'),
              Tab(text: 'Panels'),
              Tab(text: 'Batteries'),
            ],
          ),
        ),
            body: TabBarView(
            children: [
            MarketGrid(),
              MarketGrid(),
            MarketGrid(),
            MarketGrid(),
      ],
    ),));
  }
}
