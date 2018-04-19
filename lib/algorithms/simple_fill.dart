import 'dart:collection';

import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'dart:html';
import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/view/pixels.dart';

class SimpleFill {
  Color _color;

  SimpleFill(Color color) {
    this.color = color;
  }

  void draw(Bitmap bitmap, Point2D basePoint) {
    var converter = DataToColorConvertors.DataToFullStringColor();
    Pixels<String> pixels = bitmap.getAllPixels(converter);

    basePoint.round();

    String baseColor = pixels.getPixel(basePoint.x, basePoint.y);
    ListQueue<Point2D> points = new ListQueue<Point2D>();

    points.add(basePoint);
    pixels.setPixel(basePoint.x, basePoint.y, null);

    while (points.isNotEmpty) {
      Point2D point = points.removeFirst();

      bitmap.setPixel(point.x, point.y, 1, color);

      var newX = point.x;
      var newY = point.y - 1;

      if (newY >= 0) {
        if (pixels.getPixel(newX, newY) == baseColor) {
          points.add(new Point2D(newX, newY));
          pixels.setPixel(newX, newY, null);
        }
      }

      newX = point.x + 1;
      newY = point.y;
      if (newX < pixels.width) {
        if (pixels.getPixel(newX, newY) == baseColor) {
          points.add(new Point2D(newX, newY));
          pixels.setPixel(newX, newY, null);
        }
      }

      newX = point.x;
      newY = point.y + 1;
      if (newY < pixels.height) {
        if (pixels.getPixel(newX, newY) == baseColor) {
          points.add(new Point2D(newX, newY));
          pixels.setPixel(newX, newY, null);
        }
      }

      newX = point.x - 1;
      newY = point.y;
      if (newX >= 0) {
        if (pixels.getPixel(newX, newY) == baseColor) {
          points.add(new Point2D(newX, newY));
          pixels.setPixel(newX, newY, null);
        }
      }
    }

    // manualy activate GC
    pixels.dispose();
    points = null;
  }

  Color get color => _color;
  void set color(Color color) => _color = color;
}
