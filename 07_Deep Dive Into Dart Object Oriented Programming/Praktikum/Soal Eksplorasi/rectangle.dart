import 'shape.dart';

class Rectangle implements Shape {
  int width;
  int height;

  Rectangle(this.width, this.height);

  @override
  int getArea() {
    return (width * height);
  }

  @override
  int getPerimeter() {
    return (2 * (width + height));
  }
}
