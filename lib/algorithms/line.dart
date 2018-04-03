import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/math/segment.dart';
import 'package:GraphicsApp/data/color.dart';

abstract class Line {
  Color _color;
  num _width;

  Line(this._color, this._width) {}

  void draw(Bitmap bitmap, Segment segment);

  Color get color => _color;
  void set color(color) => _color = color;

  num get width => _width;
  void set width(width) => _width = width;
}
