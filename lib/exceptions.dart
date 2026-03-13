// lib/exceptions.dart

import 'dart:io';

/// Exception thrown when JSON parsing fails for a model.
///
/// Provides detailed debugging information such as:
/// - Model name
/// - Field name
/// - Expected type
/// - Received value
/// - Index (if parsing a list)
///
/// The message is formatted with ANSI colors for better
/// readability in supported terminals.
class ModelParsingException implements Exception {

  /// The name of the model that failed to parse.
  final String modelName;

  /// The field that caused the parsing error.
  final String? fieldName;

  /// The expected Dart type for the field.
  final Type? expectedType;

  /// The value received from the API.
  final dynamic receivedValue;

  /// The index if the error occurred inside a list.
  final int? index;

  /// Creates a new [ModelParsingException].
  ModelParsingException({
    required this.modelName,
    this.fieldName,
    this.expectedType,
    this.receivedValue,
    this.index,
  });

  /// ANSI color codes
  static const _red = '\x1B[31m';
  static const _yellow = '\x1B[33m';
  static const _cyan = '\x1B[36m';
  static const _reset = '\x1B[0m';
  bool get _isTest => Platform.environment.containsKey('FLUTTER_TEST');
  /// Returns a formatted error message describing the parsing issue.
  ///
  /// Includes colored output for terminals that support ANSI codes.
  @override
  String toString() {
    final buffer = StringBuffer();
    // Use colors only if NOT in test
    final red = _isTest ? '' : _red;
    final yellow = _isTest ? '' : _yellow;
    final cyan = _isTest ? '' : _cyan;
    final reset = _isTest ? '' : _reset;

    buffer.writeln("$red⚠ JSON Parsing Error$reset");
    buffer.writeln("${cyan}Model:$reset $modelName");

    if (index != null) buffer.writeln("${cyan}Index:$reset $index");
    if (fieldName != null) buffer.writeln("${cyan}Field:$reset $fieldName");
    if (expectedType != null) buffer.writeln("${cyan}Expected:$reset $expectedType");
    if (receivedValue != null) {
      buffer.writeln("${yellow}Received Type:$reset ${receivedValue.runtimeType}");
      buffer.writeln("${yellow}Value:$reset $receivedValue");
    }

    return buffer.toString();
  }
}



