class CheckDevice {
  final bool check;
  final String message;

  // TODO [LOW] (Maintainability Concerns): Non-const constructor for immutable model — Make the constructor `const` to allow compile-time instantiation and signal immutability.
  // This matters because the class is immutable (all fields are final) but without a `const` constructor callers cannot create compile-time constants; marking the constructor `const` enables better performance, clearer intent, and reduced widget rebuild cost for immutable data objects as a best practice.
  CheckDevice(this.check, this.message);
}
