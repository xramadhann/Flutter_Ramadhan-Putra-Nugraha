import 'circle.dart';
import 'square.dart';
import 'rectangle.dart';

void main() {
  final Circle circle = Circle(4);
  final Square square = Square(7);
  final Rectangle rectangle = Rectangle(7, 11);

  print(
      "Circle - Area    : ${circle.getArea()}, Perimeter: ${circle.getPerimeter()}");
  print(
      "Square - Area    : ${square.getArea()}, Perimeter: ${square.getPerimeter()}");
  print(
      "Rectangle - Area : ${rectangle.getArea()}, Perimeter: ${rectangle.getPerimeter()}");
}
