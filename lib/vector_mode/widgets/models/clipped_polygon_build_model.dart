import 'dart:html';

import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/math/polygon.dart';
import 'package:GraphicsApp/vector_mode/algorithms/clipping.dart';
import 'package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';

class ClippedPolygonBuildModel {
  List<Point2D> points;
  PolygonsModel polygons;
  Border border;
  Bitmap bitmap;

  ClippedPolygonBuildModel(this.polygons, this.bitmap) {
    points = new List();
    border = new Border();
  }

  void addPoint(MouseEvent event) {
    points.add(bitmap.computeDecartPoint(event));
    if (points.length == 2) build();
  }

  void build() {
    if (points.length != 2) throw new ArgumentError();
    var clippedPoints = clipping(points, border);

    if (clippedPoints.length == 2) {
      polygons.add(new Polygon(clippedPoints));
    }

    points = new List();
  }
}
