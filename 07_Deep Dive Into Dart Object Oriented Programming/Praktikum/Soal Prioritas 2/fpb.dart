import 'matematika.dart';

class Fpb implements Matematika {
  int x;
  int y;

  Fpb(this.x, this.y);

  int hasil() {
    while (y != 0) {
      int temp = y;
      y = x % y;
      x = temp;
    }
    return x;
  }
}
