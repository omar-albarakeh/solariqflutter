import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
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
  List<Item> allItems = [];
  List<Item> inverters = [];
  List<Item> panels = [];
  List<Item> batteries = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final itemService = ItemService();
      final items = await itemService.fetchAllItems();

      setState(() {
        allItems = items;
        inverters = items.where((item) => item.category == 'Inverters').toList();
        panels = items.where((item) => item.category == 'Panels').toList();
        batteries = items.where((item) => item.category == 'Batteries').toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text('Error: $errorMessage'))
            : TabBarView(
          children: [
            MarketGrid(items: allItems),
            MarketGrid(items: inverters),
            MarketGrid(items: panels),
            MarketGrid(items: batteries),
          ],
        ),
      ),
    );
  }
}
