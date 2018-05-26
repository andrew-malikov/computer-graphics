import 'package:GraphicsApp/math/polygon.dart';
import 'package:GraphicsApp/vector_mode/renders/render_metadata.dart';
import 'package:GraphicsApp/view/bitmap.dart';

class PolygonRender {
  RenderMetadata _metadata;

  PolygonRender(this._metadata) {}

  void render(Bitmap bitmap, Polygon polygon) {
    var sPoint = polygon.points.first;
    for (var i = 1; i < polygon.points.length; i++) {
      var ePoint = polygon.points[i];

      bitmap.drawLine(
          sPoint.x + bitmap.width / 2,
          -sPoint.y + bitmap.height / 2,
          ePoint.x + bitmap.width / 2,
          -ePoint.y + bitmap.height / 2,
          metadata.width,
          metadata.color.toRGBString());

      sPoint = ePoint;
    }
  }

  void set metadata(value) => _metadata = value;
  RenderMetadata get metadata => _metadata;
}
