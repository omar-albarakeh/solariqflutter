import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onAskEngTap;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onAskEngTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: onAskEngTap,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                ),
                child: const Text('Ask Eng', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(description, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
