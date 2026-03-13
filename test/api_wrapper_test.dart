import 'package:flutter_test/flutter_test.dart';
import 'package:model_guard/api__client_wrapper.dart';
import 'package:model_guard/example/product_model.dart';


class FakeApiClient {
  Future<Map<String, dynamic>> get(String url) async {
    return {"id": 1, "title": "iPhone", "price": 999};
  }

  Future<List<dynamic>> getList(String url) async {
    return [
      {"id": 1, "title": "iPhone", "price": 999},
      {"id": 2, "title": "Laptop", "price": "999"} // invalid
    ];
  }
}

void main() {
  group('Product ApiWrapper Tests', () {
    final client = FakeApiClient();
    final safeApi = ApiWrapper<Product>(
      apiClient: client,
      modelName: "Product",
      fromJson: (json) => Product.fromJson(json),
    );

    test('ApiWrapper single product', () async {
      final product = await safeApi.get("/product");
      expect(product?.title, "iPhone");
      expect(product?.price, 999);
    });

    test('ApiWrapper list parsing with invalid', () async {
      final products = await safeApi.getList("/products");
      expect(products.length, 1); // Only valid item
      expect(products[0].title, "iPhone");
    });
  });
}