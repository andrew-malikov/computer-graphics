import 'package:GraphicsApp/math/matrix.dart';
import "package:GraphicsApp/math/point.dart";

class Polygon {
  List<Point2D> _points;

  Polygon(List<Point2D> points) {
    if (points.length < 2) throw new ArgumentError("Low point count");

    _points = points;
  }

  void transform(Matrix transform) {
    var preTransform = newFiledMatrix(1, 1, 3);

    for (var point in _points) {
      _updateMatrix(preTransform, point);

      var postTransform = preTransform * transform;

      _updatePoint2D(postTransform, point);
    }
  }

  List<Point2D> get points => _points;
}

void _updateMatrix(Matrix matrix, Point2D point) {
  matrix.values[0][0] = point.x;
  matrix.values[0][1] = point.y;
  matrix.values[0][2] = 1;
}

void _updatePoint2D(Matrix matrix, Point2D point) {
  var row = matrix.values[0];

  if (row[2] != 1 && row[2] != 0)
    matrix.update(DefaultOperations["divide"], row[2]);

  point.x = row[0];
  point.y = row[1];
}
