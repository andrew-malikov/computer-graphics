import 'dart:html';

import 'package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/math/polygon_builder.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/models/polygon_model.dart';

class PolygonBuildModel {
  PolygonBuilder builder;
  PolygonModel previewPolygon;
  PolygonsModel polygons;
  Bitmap bitmap;

  PolygonBuildModel(this.previewPolygon, this.polygons, this.bitmap) {
    resetBuilder();
  }

  void addPoint(MouseEvent event) {
    var point = bitmap.computeDecartPoint(event);
    builder.addPoint(point);
    if (!builder.canBuild) return;
    previewPolygon.value = builder.build();
  }

  void removeLastPoint() {
    if (builder.pointCount == 0) return;
    builder.removeLastPoint();
    if (builder.canBuild)
      previewPolygon.value = builder.build();
    else
      previewPolygon.value = null;
  }

  void build() {
    if (!builder.canBuild) return;
    polygons.add(builder.build());
    previewPolygon.value = null;
    resetBuilder();
  }

  void resetBuilder() {
    builder = new PolygonBuilder();
  }
}
