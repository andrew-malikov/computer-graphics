import 'dart:collection';

import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/view/bitmap_utils.dart';

// TODO: Rewrite
class StrokeFill {
  Color _color;

  StrokeFill(Color color) {
    this.color = color;
  }

  void draw(Bitmap bitmap, Point2D point) {
    point.round();

    final baseColor = bitmap.getPixel(point.x, point.y, 1);
    final utils = new BitmapUtils(bitmap);
    final points = new ListQueue<Point2D>();

    points.add(point);

    while (points.isNotEmpty) {
      final point = points.removeFirst();
      var x = point.x;
      var y = point.y;
      var colorLine = utils.getHorizontalLine(y);

      bitmap.setPixel(x, y, 1, color);

      var rightX;
      var leftX = x;

      x++;

      while (x < bitmap.width && _getColor(colorLine, x) == baseColor) {
        bitmap.setPixel(x, y, 1, color);
        x++;
      }

      rightX = x-1;
      x = leftX - 1;

      while (x >= 0 && _getColor(colorLine, x) == baseColor) {
        bitmap.setPixel(x, y, 1, color);
        x--;
      }

      leftX = x + 1;
      if (y + 1 >= 0) {
        colorLine = utils.getHorizontalLine(y + 1);
        var intervals = _getIntervals(colorLine, leftX, rightX, baseColor);
        if (intervals.length % 2 != 0) intervals = [];

        for (var i = 1; i < intervals.length; i += 2)
          points.addLast(new Point2D(intervals[i], y + 1));
      }

      if (y - 1 <= bitmap.height) {
        colorLine = utils.getHorizontalLine(y - 1);
        var intervals = _getIntervals(colorLine, leftX, rightX, baseColor);
        if (intervals.length % 2 != 0) intervals = [];

        for (var i = 1; i < intervals.length; i += 2)
          points.addLast(new Point2D(intervals[i], y - 1));
      }
    }
  }

  Color _getColor(List<int> colorLine, num number) {
    // if (colorLine.length / 4 <= number)
    //  number = number.round() % (colorLine.length / 4);
    final channels = colorLine.sublist(number * 4, number * 4 + 4);
    return ColorBuilder.RGB(channels[0], channels[1], channels[2]);
  }

  List<num> _getIntervals(
      List<int> colorLine, int from, int to, Color baseColor) {
    var intervals = new List<int>();

    var color = _getColor(colorLine, from);
    if (color == baseColor) intervals.add(from);

    for (var i = from; i < to; i++) {
      var nextColor = _getColor(colorLine, i + 1);
      if (color == baseColor && nextColor != baseColor) {
        intervals.add(i);
        color = nextColor;
      } else if (color != baseColor && nextColor == baseColor) {
        intervals.add(i + 1);
        color = nextColor;
      }
    }

    if (_getColor(colorLine, to) == baseColor) intervals.add(to);

    return intervals;
  }

  Color get color => _color;
  void set color(Color color) => _color = color;
}
