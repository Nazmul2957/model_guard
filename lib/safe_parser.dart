/// Utility class that safely parses JSON into Dart models.
///
/// This class wraps model parsing in try-catch blocks so
/// invalid API responses do not crash the application.
/// Instead, it logs useful debugging information.
class SafeParser {

  /// Parses a single JSON object into a model.
  ///
  /// If parsing fails, the error is logged and `null` is returned.
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

  /// Parses a list of JSON objects into a list of models.
  ///
  /// Invalid items are skipped while valid ones are added
  /// to the returned list.
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
