import 'mobil.dart';
import 'hewan.dart';

void main() {
  Mobil mobil = Mobil(500);

  Hewan hewan1 = Hewan(225);
  Hewan hewan2 = Hewan(135);

  mobil.tambahMuatan(hewan1);
  mobil.totalMuatan();

  mobil.tambahMuatan(hewan2);
  mobil.totalMuatan();
}
