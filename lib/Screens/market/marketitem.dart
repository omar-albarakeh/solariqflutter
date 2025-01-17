import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
import 'cart.services.dart';
import 'itemModule.dart';

class MarketItem extends StatefulWidget {
  final Item item;

  MarketItem({required this.item});

  @override
  _MarketItemState createState() => _MarketItemState();
}

class _MarketItemState extends State<MarketItem> {
  bool isClicked = false;
  int itemQuantity = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkItemInCart();
  }

  Future<void> _checkItemInCart() async {
    final token = await TokenStorage.getToken();
    if (token != null) {
      final cartService = CartService(
        baseUrl: 'http://192.168.0.102:3001',
        authToken: token,
      );
      try {
        final cart = await cartService.fetchCart();
        final itemInCart = cart['items'].firstWhere(
              (item) => item['itemId'] == widget.item.id,
          orElse: () => null,
        );
        if (itemInCart != null) {
          setState(() {
            isClicked = true;
            itemQuantity = itemInCart['quantity'];
          });
        }
      } catch (e) {
        print("Error fetching cart: $e");
      }
    }
  }

  Future<void> _addItemToCart() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final token = await TokenStorage.getToken();
    if (token != null) {
      final cartService = CartService(
        baseUrl: 'http://192.168.0.102:3001',
        authToken: token,
      );
      try {
        await cartService.addToCart(widget.item.id ?? '', 1);
        setState(() {
          isClicked = true;
          itemQuantity += 1;
        });
      } catch (e) {
        print("Error adding item to cart: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add item to cart")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _removeItemFromCart() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    final token = await TokenStorage.getToken();
    if (token != null) {
      final cartService = CartService(
        baseUrl: 'http://192.168.0.102:3001',
        authToken: token,
      );
      try {
        await cartService.removeFromCart(widget.item.id ?? '');
        setState(() {
          itemQuantity -= 1;
          if (itemQuantity == 0) {
            isClicked = false;
          }
        });
      } catch (e) {
        print("Error removing item from cart: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to remove item from cart")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

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
                      image: NetworkImage(widget.item.imageUrl ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${widget.item.price}'),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Item Details'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Name: ${widget.item.name}"),
                                        Text("Capacity: ${widget.item.capacity}"),
                                        Text("Price: \$${widget.item.price}"),
                                        Text("Category: ${widget.item.category}"),
                                        Text("Description: ${widget.item.description}"),
                                        Text("Quantity: ${widget.item.quantity}"),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                            ),
                            child: Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: FloatingActionButton(
              onPressed: isLoading
                  ? null
                  : () {
                if (isClicked) {
                  _removeItemFromCart();
                } else {
                  _addItemToCart();
                }
              },
              backgroundColor:
              isClicked ? Colors.red : Colors.green,
              mini: true,
              child: isLoading
                  ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Icon(isClicked ? Icons.remove : Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

