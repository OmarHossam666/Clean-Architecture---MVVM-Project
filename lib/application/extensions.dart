import 'package:clean_architecture_mvvm/application/app_constants.dart';

/// Extension on nullable String to provide a default empty value.
extension NonNullString on String? {
  /// Returns [AppConstants.empty] if the string is null, otherwise returns the string itself.
  String orEmpty() => this ?? AppConstants.empty;
}

/// Extension on nullable int to provide a default zero value.
extension NonNullInt on int? {
  /// Returns [AppConstants.zero] if the integer is null, otherwise returns the integer itself.
  int orZero() => this ?? AppConstants.zero;
}
