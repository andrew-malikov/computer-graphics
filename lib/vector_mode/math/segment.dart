import 'dart:math';

import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/vector_mode/math/line.dart';

class Segment {
  Point2D a;
  Point2D b;

  Segment(this.a, this.b);

  bool contain_point(Point2D point) {
    var left_part = round((point.x - a.x) * (b.y - a.y), 5);
    var right_part = round((b.x - a.x) * (point.y - a.y), 5);

    if (left_part != right_part) return false;

    if (min(a.x, b.x) > point.x || point.x > max(a.x, b.x)) return false;

    if (min(a.y, b.y) > point.y || point.y > max(a.y, b.y)) return false;

    return true;
  }

  num get length => sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));

  static Point2D getIntersects(Segment s1, Segment s2) {
    var l1 = LineBuilder.from_segment(s1);
    var l2 = LineBuilder.from_segment(s2);
    var intersect = Line.getIntersect(l1, l2);

    if (intersect == null) return intersect;

    if (s1.contain_point(intersect) && s2.contain_point(intersect))
      return intersect;

    return null;
  }
}

num round(num number, int precision) {
  return num.parse(number.toStringAsFixed(precision));
}
