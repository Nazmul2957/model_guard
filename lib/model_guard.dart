/// Base interface for models that support JSON parsing.
///
/// Any model used with `model_guard` must implement this
/// interface so it can be safely parsed from JSON.
abstract class GuardModel {

  /// Creates a model instance from a JSON map.
  ///
  /// Implement this method in your model class to define
  /// how JSON data should be converted into a Dart object.
  GuardModel fromJson(Map<String, dynamic> json);
}