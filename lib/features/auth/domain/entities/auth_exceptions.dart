class EmailNotVerifiedException implements Exception {
  const EmailNotVerifiedException(this.message);
  final String message;

  @override
  String toString() => message;
}
