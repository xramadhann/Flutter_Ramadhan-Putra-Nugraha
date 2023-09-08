import 'shape.dart';

class Square implements Shape {
  int side;

  Square(this.side);

  @override
  int getArea() {
    return (side * side);
  }

  @override
  int getPerimeter() {
    return (4 * side);
  }
}
