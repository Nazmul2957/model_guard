import 'package:model_guard/model_guard.dart';

/// Example product model used for demonstrating model_guard usage.
class Product implements GuardModel {

  /// Product ID.
  final int id;

  /// Product title.
  final String title;

  /// Product price.
  final double price;

  /// Creates a new [Product].
  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  /// Creates a [Product] instance from JSON.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  /// Implementation required by [GuardModel].
  @override
  GuardModel fromJson(Map<String, dynamic> json) {
    return Product.fromJson(json);
  }
}