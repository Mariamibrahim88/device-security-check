class CheckDevice {
  final bool check;
  final String message;

  // TODO [LOW] (Maintainability Concerns): Non-const constructor for immutable model — Make the constructor `const` to allow compile-time instantiation and signal immutability.
  CheckDevice(this.check, this.message);
}
