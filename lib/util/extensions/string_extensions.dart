extension StringExtensions on String {
  T? enumFromString<T>(Iterable<T> values) {
    try {
      return values.firstWhere(
        (type) => type.toString().split('.').last == this,
      );
    } catch (e) {
      return null;
    }
  }
}
