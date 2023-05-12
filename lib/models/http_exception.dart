class HttbException implements Exception {
  final String message;
  HttbException(this.message);
  @override
  String toString() {
    return message;
  }
}
