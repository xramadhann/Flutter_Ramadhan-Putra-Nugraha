import 'dart:io';
import 'kelola_buku.dart';

void main() {
  PengelolaBuku pengelolaBuku = PengelolaBuku();

  while (true) {
    print("\nMenu:");
    print("1. Tambah Buku");
    print("2. Lihat Semua Buku");
    print("3. Hapus Buku");
    print("4. Keluar");
    stdout.write("Pilihan Anda: ");
    var pilihan = int.parse(stdin.readLineSync()!);

    if (pilihan == 1) {
      print("\nMasukkan detail buku:");
      stdout.write("Judul Buku: ");
      var judul = stdin.readLineSync()!;

      stdout.write("Penerbit: ");
      var penerbit = stdin.readLineSync()!;

      stdout.write("Harga: Rp");
      var harga = double.parse(stdin.readLineSync()!);

      stdout.write("Kategori: ");
      var kategori = stdin.readLineSync()!;

      pengelolaBuku.tambahBuku(judul, penerbit, harga, kategori);
    } else if (pilihan == 2) {
      print("\nDaftar Semua Buku:\n");
      for (var buku in pengelolaBuku.semuaBuku()) {
        print(
          "ID: ${buku.id}, Judul: ${buku.judul}, Penerbit: ${buku.penerbit}, Harga: Rp${buku.harga}, Kategori: ${buku.kategori}",
        );
      }
    } else if (pilihan == 3) {
      stdout.write("Masukkan ID Buku yang Ingin Dihapus: ");
      var id = int.parse(stdin.readLineSync()!);
      pengelolaBuku.hapusBuku(id);
    } else if (pilihan == 4) {
      print("Program Berakhir.");
      break;
    } else {
      print("Pilihan tidak valid.");
    }
  }
}
