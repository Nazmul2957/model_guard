// lib/api_wrapper.dart
import 'model_guard.dart';
import 'safe_parser.dart';


class ApiWrapper<T extends GuardModel> {
  final dynamic apiClient;
  final String modelName;
  final T Function(Map<String, dynamic>) fromJson; // <-- add this

  ApiWrapper({
    required this.apiClient,
    required this.modelName,
    required this.fromJson, // <-- factory function
  });

  /// Parse a single JSON object
  Future<T?> get(String url) async {
    final jsonData = await apiClient.get(url); // original API call
    return SafeParser.parse<T>(
      modelName: modelName,
      json: jsonData,
      fromJson: fromJson, // <-- pass factory
    );
  }

  /// Parse a list of JSON objects
  Future<List<T>> getList(String url) async {
    final jsonList = await apiClient.getList(url); // original API call
    return SafeParser.parseList<T>(
      modelName: modelName,
      jsonList: jsonList,
      fromJson: fromJson, // <-- pass factory
    );
  }
}