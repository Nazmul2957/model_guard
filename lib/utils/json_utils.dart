/// Checks whether a JSON value matches the expected Dart type.
///
/// Used internally to validate fields during parsing.
bool isType(dynamic value, Type type) {
  if (value == null) return false;

  if (type == int) {
    return value is int;
  } else if (type == double) {
    return value is double || value is int;
  } else if (type == String) {
    return value is String;
  } else if (type == bool) {
    return value is bool;
  } else if (type == List) {
    return value is List;
  } else if (type == Map) {
    return value is Map;
  } else {
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
