model_guard
model_guard is a lightweight Dart/Flutter utility that safely parses JSON responses and logs useful debugging information when parsing fails.

It helps developers detect incorrect API responses without crashing the application.

✨ Features

    Automatically logs parsing errors

    Shows model name + field name + invalid value

    Works with single objects and lists

    Prevents crashes from invalid JSON

    Works with any API client

    Compatible with Flutter and Dart



📦 Installation

   Add the dependency to your pubspec.yaml:

    yaml
      dependencies:
         model_guard: ^0.0.2

			
 Then run:

     bash
       flutter pub get
		 
🚀 Usage
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
    	 import 'product.dart';

		final api = ApiWrapper<Product>(
		apiClient: myApiClient, // your API client
		modelName: "Product",
		fromJson: (json) => Product.fromJson(json),
		);

		// Fetch single object
		final product = await api.get("/product");

		// Fetch list of objects
		final products = await api.getList("/products");
		Note: Invalid fields are automatically logged to the console. Invalid items in a list are skipped, so your app doesn't crash.

📝 Example API Client (for testing)

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
📋 SafeParser Logs Example
		When parsing fails, your console will show:

		text
		[ModelGuard] Product.price = wrong_type (invalid type)

📱 Flutter Widget Example

		import 'package:flutter/material.dart';
		import 'package:model_guard/api_wrapper.dart';
		import 'product.dart';

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
📄 License
This project is licensed under the MIT License.
