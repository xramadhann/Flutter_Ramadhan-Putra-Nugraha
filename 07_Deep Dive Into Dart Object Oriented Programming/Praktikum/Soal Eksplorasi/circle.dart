import 'shape.dart';

class Circle implements Shape {
  int radius;

  Circle(this.radius);

  @override
  int getArea() {
    return (3.14 * radius * radius).toInt();
  }

  @override
  int getPerimeter() {
    return (2 * 3.14 * radius).toInt();
  }
}
