/// Checks whether a JSON value matches the expected Dart type.
///
/// Used internally to validate fields during parsing.
bool isType(dynamic value, Type type) {
  if (value == null) return false;

  switch (type) {
    case int:
      return value is int;

    case double:
      return value is double || value is int;

    case String:
      return value is String;

    case bool:
      return value is bool;

    case List:
      return value is List;

    case Map:
      return value is Map;

    default:
      return true; // assume correct for custom models
  }
}

/// Retrieves a nested value from a JSON map using a path.
///
/// Example:
/// ```dart
/// getNestedField(json, ["user", "profile", "name"]);
/// ```
dynamic getNestedField(Map<String, dynamic> json, List<String> path) {
  dynamic current = json;

  for (var key in path) {
    if (current is Map<String, dynamic> && current.containsKey(key)) {
      current = current[key];
    } else {
      return null;
    }
  }

  return current;
}
