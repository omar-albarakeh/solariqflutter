import 'package:flutter/material.dart';

class MarketItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Trina 550 W',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$99'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                ),
                child: Text('Buy Now',style: TextStyle(fontSize: 12),),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                ),
                child: Text('Details',style: TextStyle(fontSize: 12),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
