import 'fpb.dart';
import 'kpk.dart';
import 'matematika.dart';

void main() {
  final Matematika KPK = Kpk(12, 18);
  final Matematika FPB = Fpb(24, 36);

  print("KPK: ${KPK.hasil()}");
  print("FPB: ${FPB.hasil()}");
}
