void main() {
  int rows = 5;
  for (int i = 1; i <= rows; i++) {
    print(' ' * (i - 1) + '0' * (2 * (rows - i) + 1));
  }
  for (int i = rows - 1; i >= 1; i--) {
    print(' ' * (i - 1) + '0' * (2 * (rows - i) + 1));
  }
}
