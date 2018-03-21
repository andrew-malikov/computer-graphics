import '../math/point.dart';
import '../math/segment.dart';
import '../view/bitmap.dart';
import './line.dart';

Map getLengths(Segment segment) {
  num dx = segment.abscissaLength;
  num dy = segment.ordinateLength;
  if (dx >= dy) return { 'dx': dx, 'dy': dy, 'swap': false };
  return { 'dx': dy, 'dy': dx, 'swap': true };
}

class BresenhamLine extends Line {
  BresenhamLine(String color, num width) : super(color, width);

  /* FIXME: Update method realization */
  void draw(Bitmap bitmap, Segment segment) {
    if(segment.isPoint()) return;
    Point2D point = segment.start.clone();
    Map lengths = getLengths(segment);
    Point2D directions = new Point2D(segment.abscissaDirection, segment.ordinateDirection);
    num error = (2 * lengths['dy']) - lengths['dx'];

    for (int i = 0; i <= lengths['dx']; i++) {
      bitmap.setPixel(point.x.ceil(), point.y.ceil(), width, color);
      while (error >= 0) {
        lengths['swap'] ? point.x += directions.x : point.y += directions.y;
        error -= 2 * lengths['dx'];
      }
      lengths['swap'] ? point.y += directions.y : point.x += directions.x;
      error += 2 * lengths['dy'];
    }
  }
}
