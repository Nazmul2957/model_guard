// lib/safe_parser.dart



class SafeParser {
  /// Parse a single JSON object into a model
  static T? parse<T>({
    required String modelName,
    required Map<String, dynamic> json,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    try {
      final model = fromJson(json);
      return model;
    } catch (e) {
      // Print detailed error
      print("⚠ JSON Parsing Error");
      print("Model: $modelName");
      print("Error: $e");
      print("JSON: $json");
      return null;
    }
  }

  /// Parse a list of JSON objects into a list of models
  static List<T> parseList<T>({
    required String modelName,
    required List<dynamic> jsonList,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    List<T> result = [];
    for (var i = 0; i < jsonList.length; i++) {
      final item = jsonList[i];
      try {
        final model = fromJson(item);
        result.add(model);
      } catch (e) {
        print("⚠ JSON Parsing Error");
        print("Model: $modelName");
        print("Index: $i");
        print("Error: $e");
        print("Item: $item");
      }
    }
    return result;
  }
}