# model_guard

**Automatic JSON parser for Flutter/Dart** that safely parses API responses and logs **model name + field name + invalid value** whenever parsing fails.

It helps developers catch errors in JSON parsing **without crashing the app**, making your API handling more robust.

---

## Features

- Automatically logs parsing errors for each field
- Works for single objects and lists
- Minimal setup with any API client
- Compatible with Flutter and Dart

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  model_guard:
    git:
      url: https://github.com/YOUR_GITHUB_USERNAME/model_guard.git

Then run:
    flutter pub get

Usage Example
1. Define your model
import 'package:model_guard/guard_model.dart';

class Product implements GuardModel {
  final int id;
  final String title;
  final double price;

  Product({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  GuardModel fromJson(Map<String, dynamic> json) => Product.fromJson(json);
}

2. Wrap your API client

import 'package:model_guard/api_wrapper.dart';
import 'example/product.dart';

final api = ApiWrapper<Product>(
  apiClient: myApiClient, // your API client
  modelName: "Product",
  fromJson: (json) => Product.fromJson(json),
);

final product = await api.get("/product");        // single object
final products = await api.getList("/products"); // list of objects

 .Invalid fields are automatically logged to the console

 .Invalid items in a list are skipped, so your app doesn’t crash

3. Example API Client (for testing)

class FakeApiClient {
  Future<Map<String, dynamic>> get(String url) async {
    return {"id": 1, "title": "iPhone", "price": 999};
  }

  Future<List<dynamic>> getList(String url) async {
    return [
      {"id": 1, "title": "iPhone", "price": 999},
      {"id": 2, "title": "Laptop", "price": "wrong_type"} // invalid
    ];
  }
}

4. SafeParser Logs Example

When parsing fails, your console will show:

  [ModelGuard] Product.price = wrong_type (invalid type)

5. Flutter Widget Example
import 'package:flutter/material.dart';
import 'package:model_guard/api_wrapper.dart';
import 'package:model_guard/example/product.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  void fetchProducts() async {
    final client = FakeApiClient();
    final api = ApiWrapper<Product>(
      apiClient: client,
      modelName: "Product",
      fromJson: (json) => Product.fromJson(json),
    );

    final result = await api.getList("/products");
    setState(() {
      products = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final p = products[index];
        return ListTile(
          title: Text(p.title),
          subtitle: Text("Price: \$${p.price}"),
        );
      },
    );
  }
}

// Fake API Client for demo
class FakeApiClient {
  Future<Map<String, dynamic>> get(String url) async {
    return {"id": 1, "title": "iPhone", "price": 999};
  }

  Future<List<dynamic>> getList(String url) async {
    return [
      {"id": 1, "title": "iPhone", "price": 999},
      {"id": 2, "title": "Laptop", "price": "wrong_type"} // invalid
    ];
  }
}


