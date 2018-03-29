import '../view/bitmap.dart';
import '../math/point.dart';

import 'dart:collection';

class Fill {
  String _color;

  Fill(String color) {
    color = color;
  }

  void draw(Bitmap bitmap, Point2D basePoint) {
    String baseColor = bitmap.getPixel(basePoint.x, basePoint.y, 1);
    ListQueue<Point2D> points = new ListQueue<Point2D>();

    points.add(basePoint);

    while (points.isNotEmpty) {
      Point2D point = points.last;
      points.removeLast();
      bitmap.setPixel(point.x, point.y, 1, color);
      _addNearPointsToQueue(bitmap, point, points, baseColor);
    }
  }

  void _addNearPointsToQueue(Bitmap bitmap, Point2D point, ListQueue<Point2D> queue,
      String baseColor) {
    List<Point2D> checkPoints = [
      Point2DManipulator.moveUp(point),
      Point2DManipulator.moveRight(point),
      Point2DManipulator.moveDown(point),
      Point2DManipulator.moveLeft(point)
    ];
    for (Point2D point in checkPoints) {
      if (bitmap.getPixel(point.x, point.y, 1) == baseColor) queue.add(point);
    }
  }

  String get color => _color;
  void set color(String color) => _color = color;
}
