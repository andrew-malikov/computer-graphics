import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'Package:GraphicsApp/math/segment.dart';

class Circle {
  String _color;
  num _width;

  Circle(this._color, this._width) {}

  Circle.standart() : this('#000', 1);

  // TODO: Update method realization
  void draw(Bitmap bitmap, Segment segment) {
    num length = segment.length.ceil();
    if (length <= 1) return;
    num error = 2 * (1 - length);
    Point2D point = new Point2D(0, length);

    while (point.x <= length && point.y >= 0) {
      drawArcs(bitmap, point, segment.start);
      error = _updatePointAndError(point, error);
    }
  }

  /* return updated error */
  num _updatePointAndError(Point2D point, num error) {
    num side = 0;
    if (error < 0) {
      side = 2 * error + 2 * point.y - 1;
      if (side <= 0)
        return _movePointHorizontally(point, error);
      else
        return _movePointDiagonally(point, error);
    } else if (error > 0) {
      side = 2 * error + 2 * point.x - 1;
      if (error <= 0)
        return _movePointDiagonally(point, error);
      else
        return _movePointVertically(point, error);
    } else
      return _movePointDiagonally(point, error);
  }

  /* return updated error */
  num _movePointDiagonally(Point2D point, num error) {
    point.x += 1;
    point.y -= 1;
    return error + 2 * point.x - 2 * point.y + 2;
  }

  num _movePointHorizontally(Point2D point, num error) {
    point.x += 1;
    return error + 2 * point.x + 1;
  }

  num _movePointVertically(Point2D point, num error) {
    point.y -= 1;
    return error - 2 * point.y + 1;
  }

  void drawArcs(Bitmap bitmap, Point2D point, Point2D center) {
    bitmap.setPixel(center.x + point.x, center.y + point.y, width, color);
    bitmap.setPixel(center.x - point.x, center.y + point.y, width, color);
    bitmap.setPixel(center.x - point.x, center.y - point.y, width, color);
    bitmap.setPixel(center.x + point.x, center.y - point.y, width, color);
  }

  String get color => _color;
  void set color(color) => _color = color;

  num get width => _width;
  void set width(width) => _width = width;
}
