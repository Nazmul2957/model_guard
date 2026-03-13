// lib/api_wrapper.dart

import 'model_guard.dart';
import 'safe_parser.dart';

/// A generic wrapper for API calls that automatically parses
/// JSON responses into strongly typed models.
///
/// This class works with models that extend [GuardModel].
/// It uses a provided `fromJson` factory to safely convert
/// API responses into Dart objects.
///
/// Example:
/// ```dart
/// final api = ApiWrapper<UserModel>(
///   apiClient: client,
///   modelName: "UserModel",
///   fromJson: (json) => UserModel.fromJson(json),
/// );
///
/// final user = await api.get("/user/1");
/// ```
class ApiWrapper<T extends GuardModel> {

  /// The API client used to perform network requests.
  ///
  /// This can be any client that provides `get` and `getList` methods.
  final dynamic apiClient;

  /// The name of the model used for debugging and error reporting.
  final String modelName;

  /// Factory function used to convert JSON into a model instance.
  final T Function(Map<String, dynamic>) fromJson;

  /// Creates an [ApiWrapper] instance.
  ///
  /// Requires an [apiClient], the [modelName], and a [fromJson] factory
  /// to convert JSON responses into models.
  ApiWrapper({
    required this.apiClient,
    required this.modelName,
    required this.fromJson,
  });

  /// Fetches a single object from the API and parses it into a model.
  ///
  /// Returns `null` if parsing fails.
  Future<T?> get(String url) async {
    final jsonData = await apiClient.get(url);

    return SafeParser.parse<T>(
      modelName: modelName,
      json: jsonData,
      fromJson: fromJson,
    );
  }

  /// Fetches a list of objects from the API and parses them into models.
  ///
  /// Returns an empty list if parsing fails.
  Future<List<T>> getList(String url) async {
    final jsonList = await apiClient.getList(url);

    return SafeParser.parseList<T>(
      modelName: modelName,
      jsonList: jsonList,
      fromJson: fromJson,
    );
  }
}