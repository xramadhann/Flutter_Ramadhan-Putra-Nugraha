void main() {
  int angka = 9;

  print("Tabel Perkalian: $angka");

  for (int x = 1; x <= angka; x++) {
    String baris = "";
    for (int r = 1; r <= angka; r++) {
      baris += (x * r).toString().padLeft(4);
    }
    print(baris);
  }
}
