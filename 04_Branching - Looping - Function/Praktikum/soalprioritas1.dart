void main() {
  int tingkat = 5;
  for (int i = 1; i <= tingkat; i++) {
    String spasi = ' ' * (tingkat - i); // Menghitung spasi sebelum bintang
    String bintang =
        '*' * (2 * i - 1); // Menghitung jumlah bintang pada setiap baris
    print(spasi + bintang);
  }
}
