import 'dart:collection';

import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/data/color.dart';

class SimpleFill {
  Color _color;

  SimpleFill(Color color) {
    this.color = color;
  }

  void draw(Bitmap bitmap, Point2D basePoint) {
    basePoint.round();

    Color baseColor = bitmap.getPixel(basePoint.x, basePoint.y, 1);
    ListQueue<Point2D> points = new ListQueue<Point2D>();

    points.add(basePoint);
    bitmap.setPixel(basePoint.x, basePoint.y, 1, color);

    while (points.isNotEmpty) {
      Point2D point = points.removeFirst();

      List<Point2D> nearPoints = [
        Point2DManipulator.moveUp(point),
        Point2DManipulator.moveRight(point),
        Point2DManipulator.moveDown(point),
        Point2DManipulator.moveLeft(point)
      ];

      for (var point in nearPoints) {
        if (!bitmap.containPoint(point.x, point.y) ||
            bitmap.getPixel(point.x, point.y, 1) != baseColor) continue;
        bitmap.setPixel(point.x, point.y, 1, color);
        points.add(point);
      }
    }
    // manualy activate GC
    points = null;
  }

  @Deprecated('To many calls')
  void _addNearPointsToQueue(
      Bitmap bitmap, Point2D point, ListQueue<Point2D> queue, Color baseColor) {
    List<Point2D> checkPoints = [
      Point2DManipulator.moveUp(point),
      Point2DManipulator.moveRight(point),
      Point2DManipulator.moveDown(point),
      Point2DManipulator.moveLeft(point)
    ];
    for (Point2D point in checkPoints) {
      if (!bitmap.containPoint(point.x, point.y) || queue.contains(point))
        continue;
      if (bitmap.getPixel(point.x, point.y, 1) == baseColor) queue.add(point);
    }
  }

  Color get color => _color;
  void set color(Color color) => _color = color;
}
