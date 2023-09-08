import 'buku.dart';

class PengelolaBuku {
  List<Buku> daftarBuku = [];
  int _idCounter = 1;

  void tambahBuku(
    String judul,
    String penerbit,
    double harga,
    String kategori,
  ) {
    Buku bukuBaru = Buku(_idCounter, judul, penerbit, harga, kategori);
    daftarBuku.add(bukuBaru);
    _idCounter++;
    print("Buku '${bukuBaru.judul}' ditambahkan dengan ID: ${bukuBaru.id}");
  }

  List<Buku> semuaBuku() {
    return daftarBuku;
  }

  void hapusBuku(int id) {
    Buku? bukuYangDihapus;

    for (var buku in daftarBuku) {
      if (buku.id == id) {
        bukuYangDihapus = buku;
        break;
      }
    }

    if (bukuYangDihapus != null) {
      daftarBuku.remove(bukuYangDihapus);
      print("Buku '${bukuYangDihapus.judul}' dengan ID: $id dihapus.");
    } else {
      print("Buku dengan ID: $id tidak ditemukan.");
    }
  }
}
