// lib/exceptions.dart
class ModelParsingException implements Exception {
  final String modelName;
  final String? fieldName;
  final dynamic expectedType;
  final dynamic receivedValue;
  final int? index;

  ModelParsingException({
    required this.modelName,
    this.fieldName,
    this.expectedType,
    this.receivedValue,
    this.index,
  });

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln("⚠ JSON Parsing Error");
    buffer.writeln("Model: $modelName");
    if (index != null) buffer.writeln("Index: $index");
    if (fieldName != null) buffer.writeln("Field: $fieldName");
    if (expectedType != null) buffer.writeln("Expected: $expectedType");
    if (receivedValue != null) buffer.writeln("Received: ${receivedValue.runtimeType}");
    if (receivedValue != null) buffer.writeln("Value: $receivedValue");
    return buffer.toString();
  }
}