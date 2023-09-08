import 'kubus.dart';
import 'balok.dart';

void main() {
  Kubus kubus = Kubus(8);
  print('Volume Kubus: ${kubus.volume()}');

  Balok balok = Balok(6, 9, 11);
  print('Volume Balok: ${balok.volume()}');
}
