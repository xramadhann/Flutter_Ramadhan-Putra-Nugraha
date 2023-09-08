import 'hewan.dart';

class Mobil {
  double kapasitas;
  List<Hewan> muatan = [];

  Mobil(this.kapasitas);

  void tambahMuatan(Hewan hewan) {
    if (kapasitas >= _totalMuatan() + hewan.berat) {
      muatan.add(hewan);
      print('Hewan ditambahkan ke dalam muatan.');
    } else {
      print('Kapasitas tidak mencukupi.');
    }
  }

  double _totalMuatan() {
    double total = 0;
    for (var hewan in muatan) {
      total += hewan.berat;
    }
    return total;
  }

  void totalMuatan() {
    print('Total muatan saat ini adalah: ${_totalMuatan()} Kg');
  }
}
