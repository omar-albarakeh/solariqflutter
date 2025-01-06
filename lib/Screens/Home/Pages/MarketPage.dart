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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: CartPage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
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
          ),
        ));
  }
}
