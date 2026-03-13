
import 'package:model_guard/model_guard.dart';

import '../lib/api__client_wrapper.dart';

class Product implements GuardModel {
  final int id;
  final String title;

  Product({required this.id, required this.title});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  GuardModel fromJson(Map<String, dynamic> json) => Product.fromJson(json);
}

class FakeApiClient {
  Future<Map<String, dynamic>> get(String url) async {
    return {"id": 1, "title": "Phone"};
  }

  Future<List<dynamic>> getList(String url) async {
    return [
      {"id": 1, "title": "Phone"},
      {"id": 2, "title": "Laptop"}
    ];
  }
}

void main() async {
  final api = ApiWrapper<Product>(
    apiClient: FakeApiClient(),
    modelName: "Product",
    fromJson: (json) => Product.fromJson(json),
  );

  final product = await api.get("/product");

  print(product);
}