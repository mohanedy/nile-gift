extension SafeStringExt on String? {
  String get safeStr {
    return this ?? 'N/A';
  }
}