import '../model_guard.dart';

class Product implements GuardModel {
  final int id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  // Factory constructor for parsing JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        price: (json['price'] ?? 0).toDouble(),
      );
    } catch (e) {
      // Optional: you can also log here
      throw Exception("Product parsing error: $json");
    }
  }

  @override
  GuardModel fromJson(Map<String, dynamic> json) => Product.fromJson(json);
}