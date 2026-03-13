import 'package:flutter_test/flutter_test.dart';

import 'package:model_guard/example/product_model.dart';
import 'package:model_guard/safe_parser.dart';


void main() {
  group('Product SafeParser Tests', () {
    test('Single product valid JSON', () {
      final jsonData = {"id": 1, "title": "iPhone", "price": 999};

      final product = SafeParser.parse<Product>(
        modelName: "Product",
        json: jsonData,
        fromJson: (json) => Product.fromJson(json),
      );

      expect(product?.id, 1);
      expect(product?.title, "iPhone");
      expect(product?.price, 999);
    });

    test('Single product invalid JSON returns null', () {
      final jsonData = {"id": 2, "title": "Laptop", "price": "wrong_type"};

      final product = SafeParser.parse<Product>(
        modelName: "Product",
        json: jsonData,
        fromJson: (json) => Product.fromJson(json),
      );

      expect(product, null);
    });

    test('List parsing with one invalid item', () {
      final jsonList = [
        {"id": 1, "title": "iPhone", "price": 999},
        {"id": 2, "title": "Laptop", "price": "wrong_type"}
      ];

      final products = SafeParser.parseList<Product>(
        modelName: "Product",
        jsonList: jsonList,
        fromJson: (json) => Product.fromJson(json),
      );

      expect(products.length, 1); // Only valid item added
      expect(products[0].title, "iPhone");
    });
  });
}