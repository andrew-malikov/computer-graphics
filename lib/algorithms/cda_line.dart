import 'Package:GraphicsApp/math/point.dart';
import 'Package:GraphicsApp/math/segment.dart';
import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/algorithms/line.dart';
import 'package:GraphicsApp/data/color.dart';

class CDALine extends Line {
  CDALine(Color color, num width) : super(color, width);

  void draw(Bitmap bitmap, Segment segment) {
    num length = segment.longProjectionOnAxis;
    Point2D increment = new Point2D(
        segment.abscissaLength * segment.abscissaDirection / length,
        segment.ordinateLength * segment.ordinateDirection / length);
    Point2D point = segment.start.clone();

    for (int i = 0; i < length; i++) {
      bitmap.setPixel(point.x.ceil(), point.y.ceil(), width, color);
      point = point + increment;
    }
  }
}
