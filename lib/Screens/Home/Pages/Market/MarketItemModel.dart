class MarketItemModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final String description;
  final String imageUrl;
  final int quantity;

  MarketItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.quantity,
  });

  factory MarketItemModel.fromJson(Map<String, dynamic> json) {
    return MarketItemModel(
      id: json['_id'], // Map '_id' from JSON to 'id' in the model
      name: json['name'],
      price: json['price'].toDouble(),
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }
}