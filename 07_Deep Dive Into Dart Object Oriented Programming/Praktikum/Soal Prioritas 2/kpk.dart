import 'matematika.dart';

class Kpk implements Matematika {
  int x;
  int y;

  Kpk(this.x, this.y);

  int hasil() {
    int max = (x > y) ? x : y;
    while (true) {
      if (max % x == 0 && max % y == 0) {
        return max;
      }
      max++;
    }
  }
}
