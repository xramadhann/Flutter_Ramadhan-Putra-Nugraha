void main() {
  int angka = 17;

  if (bilPrima(angka)) {
    print("$angka adalah bilangan prima.");
  } else {
    print("$angka bukan bilangan prima.");
  }
}

bool bilPrima(int n) {
  if (n <= 1) {
    return false;
  }
  for (int i = 2; i <= n / 2; i++) {
    if (n % i == 0) {
      return false;
    }
  }
  return true;
}
