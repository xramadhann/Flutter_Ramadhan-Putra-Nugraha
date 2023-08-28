void main() {
  List<int> angka = [10, 40, 50];

  for (int value in angka) {
    print("Faktorial dari $value adalah ${calculateFactorial(value)}");
  }
}

BigInt calculateFactorial(int n) {
  BigInt factorial = BigInt.one;
  for (int i = 1; i <= n; i++) {
    factorial *= BigInt.from(i);
  }
  return factorial;
}
