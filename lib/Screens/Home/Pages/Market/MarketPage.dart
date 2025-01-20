// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'MarketGrid.dart';
// import 'MarketItemModel.dart';
//
// class MarketPage extends StatefulWidget {
//   const MarketPage({super.key});
//
//   @override
//   State<MarketPage> createState() => _MarketPageState();
// }
//
// class _MarketPageState extends State<MarketPage> {
//   List<MarketItemModel> allItems = [];
//   List<MarketItemModel> inverters = [];
//   List<MarketItemModel> panels = [];
//   List<MarketItemModel> batteries = [];
//   bool isLoading = false; // Add a loading state
//   String errorMessage = '';
//
//   get http => null; // Add an error message state
//
//   @override
//   void initState() {
//     super.initState();
//     fetchItems();
//   }
//
//   Future<void> fetchItems() async {
//     const baseUrl = 'http://192.168.0.103:3001/items'; // Replace with IP if needed for real devices.
//
//     setState(() {
//       isLoading = true; // Start loading
//       errorMessage = ''; // Clear any previous errors
//     });
//
//     try {
//       print('Fetching items from $baseUrl...');
//       final response = await http.get(Uri.parse(baseUrl));
//       print('Response received with status: ${response.statusCode}');
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body); // Parse as a Map
//         print('Data fetched successfully: $data');
//
//         final List<dynamic> items = data['items']; // Extract the "items" array
//         print('Items list: $items');
//
//         final fetchedItems = items.map((item) => MarketItemModel.fromJson(item)).toList();
//
//         setState(() {
//           allItems = fetchedItems;
//           inverters = filterItemsByCategory(fetchedItems, 'Inverters');
//           panels = filterItemsByCategory(fetchedItems, 'Panels');
//           batteries = filterItemsByCategory(fetchedItems, 'Batteries');
//           isLoading = false; // Stop loading
//         });
//
//         print('Items updated in state.');
//       } else {
//         setState(() {
//           errorMessage = 'Failed to fetch items. Status code: ${response.statusCode}';
//           isLoading = false; // Stop loading
//         });
//         print(errorMessage);
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error occurred during fetch: $e';
//         isLoading = false; // Stop loading
//       });
//       print(errorMessage);
//     }
//   }
//
//   // Helper function to filter items by category
//   List<MarketItemModel> filterItemsByCategory(List<MarketItemModel> items, String category) {
//     return items.where((item) => item.category == category).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Market'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.shopping_cart),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return Dialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       insetPadding: EdgeInsets.all(20),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           height: MediaQuery.of(context).size.height * 0.6,
//                           child: Center(child: Text('Cart Page Placeholder')),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//           bottom: TabBar(
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white30,
//             tabs: [
//               Tab(text: 'All'),
//               Tab(text: 'Inverters'),
//               Tab(text: 'Panels'),
//               Tab(text: 'Batteries'),
//             ],
//           ),
//         ),
//         body: isLoading
//             ? Center(child: CircularProgressIndicator()) // Show loading indicator
//             : errorMessage.isNotEmpty
//             ? Center(child: Text(errorMessage)) // Show error message
//             : TabBarView(
//           children: [
//             MarketGrid(items: allItems),
//             MarketGrid(items: inverters),
//             MarketGrid(items: panels),
//             MarketGrid(items: batteries),
//           ],
//         ),
//       ),
//     );
//   }
// }