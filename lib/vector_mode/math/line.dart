import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/vector_mode/math/segment.dart';

class Line {
  num a;
  num b;
  num c;

  Line(this.a, this.b, this.c);

  num substitute(Point2D point) => a * point.x + b * point.y + c;

  bool containPoint(Point2D point) => substitute(point) == 0;

  static bool isParallel(Line l1, Line l2) => l1.a * l2.b == l2.a * l1.b;

  /// if the lines intersect, return point, otherwise false
  static Point2D getIntersect(Line l1, Line l2) {
    if (Line.isParallel(l1, l2)) return null;

    num x, y;
    if (l1.a != 0) {
      y = (l2.a * l1.c - l1.a * l2.c) / (l1.a * l2.b - l2.a * l1.b);
      x = (-l1.b * y - l1.c) / l1.a;
    } else if (l2.a != 0) {
      y = (l2.c * l1.a - l1.c * l2.a) / (l1.b * l2.a - l2.b * l1.a);
      x = (-l2.c - l2.b * y) / l2.a;
    }

    return new Point2D(x, y);
  }
}

class LineBuilder {
  static Line from_points(Point2D p1, Point2D p2) {
    num a = p1.y - p2.y;
    num b = p2.x - p1.x;
    num c = -b * p1.y - a * p1.x;
    return new Line(a, b, c);
  }

  static Line from_function(num k, num m) {
    num a = k;
    num b = -1;
    num c = m;
    return new Line(a, b, c);
  }

  static Line from_segment(Segment segment) {
    return LineBuilder.from_points(segment.a, segment.b);
  }
}
