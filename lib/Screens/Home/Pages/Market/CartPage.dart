import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCartItem(),
            SizedBox(height: 16.0),
            buildOrderSummary(),
            SizedBox(height: 16.0),
            buildAddressField(),
            SizedBox(height: 16.0),
            buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            color: Colors.grey,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trina panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text('\$81'),
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }


  Widget buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null,
        ),
        Text(
          value,
          style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null,
        ),
      ],
    );
  }


  Widget buildOrderSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          buildSummaryRow('Order', '\$81'),
          buildSummaryRow('Delivery', '\$6'),
          Divider(),
          buildSummaryRow('Total', '\$87', isBold: true),
        ],
      ),
    );
  }

  Widget buildAddressField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          address = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
  Widget buildCheckoutButton() {
    return ElevatedButton(
      onPressed: () {
      },
      child: Text('Check Out'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}