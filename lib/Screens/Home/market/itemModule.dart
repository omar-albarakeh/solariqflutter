class Item {
  final String? id;
  final String? name;
  final double? price;
  final double? capacity;
  final String? category;
  final String? description;
  final String? imageUrl;
  final int? quantity;

  Item({
    this.id,
    this.name,
    this.price,
    this.capacity,
    this.category,
    this.description,
    this.imageUrl,
    this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      capacity: (json['capacity'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? 'Uncategorized',
      description: json['description'] as String? ?? 'No description',
      imageUrl: json['imageUrl'] as String? ?? 'https://example.com/default.jpg',
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  // Method to convert an Item to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'capacity': capacity,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}