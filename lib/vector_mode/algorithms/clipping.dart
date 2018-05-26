import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/vector_mode/math/segment.dart';

/// Items
/// - first - up
/// - second - bottom
/// - third - right
/// - fourth - left
class Code {
  List<int> values;

  Code() {
    values = new List<int>(4);
    values.fillRange(0, 4, 0);
  }

  bool get isZero {
    for (var value in values) if (value != 0) return false;
    return true;
  }

  get up => values[0];
  set up(int value) => values[0] = value % 2;

  get down => values[1];
  set down(int value) => values[1] = value % 2;

  get right => values[2];
  set right(int value) => values[2] = value % 2;

  get left => values[3];
  set left(int value) => values[3] = value % 2;

  Code operator *(Code code) {
    var conjunctionCode = new Code();

    for (var i = 0; i < code.values.length; i++) {
      conjunctionCode.values[i] = values[i] * code.values[i];
    }

    return conjunctionCode;
  }
}

class Border {
  List<num> values;

  Border() {
    values = new List<num>(4);
    values.fillRange(0, 4, 0);
  }

  /// items
  /// - first - left-up
  /// - second - right-up
  /// - third - right-down
  /// - fourth - left-down
  List<Point2D> computePoints() {
    return [
      new Point2D(left, up),
      new Point2D(right, up),
      new Point2D(right, down),
      new Point2D(left, down)
    ];
  }

  List<Segment> computeSegments() {
    var points = computePoints();
    return [
      new Segment(points[0], points[1]),
      new Segment(points[1], points[2]),
      new Segment(points[2], points[3]),
      new Segment(points[3], points[0])
    ];
  }

  get up => values[0];
  set up(num value) => values[0] = value;

  get down => values[1];
  set down(num value) => values[1] = value;

  get right => values[2];
  set right(num value) => values[2] = value;

  get left => values[3];
  set left(num value) => values[3] = value;
}

List<Point2D> clipping(List<Point2D> points, Border border) {
  var codes = new List<Code>();
  points.forEach((p) => codes.add(_computeCode(p, border)));

  if (!(codes[0] * codes[1]).isZero) return null;
  if (codes[0].isZero && codes[1].isZero) return points;

  var clippedPoints = new List<Point2D>();
  for (var i = 0; i < codes.length; i++)
    if (codes[i].isZero) clippedPoints.add(points[i]);

  var segment = new Segment(points[0], points[1]);
  for (var other in border.computeSegments()) {
    var intersect = Segment.getIntersects(segment, other);
    if (intersect != null) clippedPoints.add(intersect);
  }

  return clippedPoints;
}

Code _computeCode(Point2D point, Border border) {
  var code = new Code();

  if (point.y > border.up) code.up = 1;
  if (point.y < border.down) code.down = 1;
  if (point.x > border.right) code.right = 1;
  if (point.x < border.left) code.left = 1;

  return code;
}
