import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/math/segment.dart';

abstract class Line {
  String _color;
  num _width;

  Line(this._color, this._width) {}

  Line.standart() : this('#000', 1);

  void draw(Bitmap bitmap, Segment segment);

  String get color => _color;
  void set color(color) => _color = color;

  num get width => _width;
  void set width(width) => _width = width;
}
