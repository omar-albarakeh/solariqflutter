import 'package:flutter/material.dart';
import '../../../Config/SharedPreferences.dart';
import 'cart.services.dart';
import 'itemModule.dart';
import 'marketgrid.dart';
import 'marketservice.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late Future<List<Item>> _itemsFuture;
  final ItemService _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    _itemsFuture = _itemService.fetchAllItems();
  }

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
              onPressed: () async {
                try {
                  final token = await TokenStorage.getToken();
                  if (token == null) {
                    throw Exception('User is not logged in');
                  }

                  final cartService = CartService(
                    baseUrl: 'http://192.168.0.102:3001',
                    authToken: token,
                  );

                  final cart = await cartService.fetchCart();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        insetPadding: EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ListView.builder(
                              itemCount: cart['items'].length,
                              itemBuilder: (context, index) {
                                final item = cart['items'][index];
                                return ListTile(
                                  title: Text(item['itemId']['name']),
                                  subtitle: Text('Quantity: ${item['quantity']}'),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to fetch cart: $e'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Inverters'),
              Tab(text: 'Panels'),
              Tab(text: 'Batteries'),
            ],
          ),
        ),
        body: FutureBuilder<List<Item>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No items available'));
            } else {
              final allItems = snapshot.data!;
              final inverters = allItems.where((item) => item.category == 'Inverters').toList();
              final panels = allItems.where((item) => item.category == 'Panels').toList();
              final batteries = allItems.where((item) => item.category == 'Batteries').toList();

              return TabBarView(
                children: [
                  MarketGrid(items: allItems),
                  MarketGrid(items: inverters),
                  MarketGrid(items: panels),
                  MarketGrid(items: batteries),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}