import 'bangun_ruang.dart';

class Balok extends BangunRuang {
  Balok(double panjang, double lebar, double tinggi)
      : super(panjang, lebar, tinggi);

  @override
  double volume() {
    return panjang * lebar * tinggi;
  }
}
