import 'dart:io';

void main() {
  stdout.write("Masukkan nilai: ");
  String input = stdin.readLineSync()!;

  List<int> nilai = [];

  List<String> nilaiList = input.split(",");

  for (String nilaiStr in nilaiList) {
    int? nilaiInt = int.tryParse(nilaiStr.trim());
    if (nilaiInt != null) {
      nilai.add(nilaiInt);
    } else {
      print("Input tidak valid");
      return;
    }
  }

  int hitungRataRata(List<int> data) {
    int total = data.reduce((value, element) => value + element);
    double rataRata = total / data.length;
    int rataRataBulat = rataRata.ceil();
    return rataRataBulat;
  }

  int hasil = hitungRataRata(nilai);
  print("Hasil rata-rata: $hasil");
}
