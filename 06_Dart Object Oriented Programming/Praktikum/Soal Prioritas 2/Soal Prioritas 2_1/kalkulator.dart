class Kalculator {
  double penjumlahan(double a, double b) {
    return a + b;
  }

  double pengurangan(double a, double b) {
    return a - b;
  }

  double perkalian(double a, double b) {
    return a * b;
  }

  double pembagian(double a, double b) {
    if (b != 0) {
      return a / b;
    } else {
      throw ArgumentError("Denominator cannot be zero.");
    }
  }
}
