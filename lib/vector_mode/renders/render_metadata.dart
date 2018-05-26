import 'package:GraphicsApp/data/color.dart';

class RenderMetadata {
  Color _color;
  num _width;

  RenderMetadata(this._color, this._width) {}

  Color get color => _color;
  void set color(color) => _color = color;

  num get width => _width;
  void set width(width) => _width = width;
}