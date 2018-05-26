import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/math/polygon.dart';

class PolygonBuilder {
  List<Point2D> _points;

  PolygonBuilder() {
    _points = new List<Point2D>();
  }

  PolygonBuilder addPoint(Point2D point) {
    _points.add(point);
    return this;
  }

  PolygonBuilder removeLastPoint() {
    _points.removeLast();
    return this;
  }

  bool get canBuild => _points.length > 1;

  int get pointCount => _points.length;

  Polygon build() => new Polygon(_points);
}
