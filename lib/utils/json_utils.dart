// lib/utils/json_utils.dart
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