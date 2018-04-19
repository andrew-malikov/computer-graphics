import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/view/pixels.dart';

class Translate {
  void execute(
      Bitmap bitmap, Point2D point, Point2D size, Point2D movingValue) {
    movingValue.round();

    var converter = DataToColorConvertors.DataToFullStringColor();
    var x = point.x;
    var y = point.y;
    var width = size.x;
    var height = size.y;

    var pixels = bitmap.getPixels<String>(x, y, width, height, converter);

    bitmap.fillArea(x, y, width, height, DefaultColors['white']);

    for (var i = 0; i < pixels.width; i++) {
      for (var j = 0; j < pixels.height; j++) {
        var newX = i + x + movingValue.x;
        var newY = j + y + movingValue.y;

        bitmap.setRawPixel(newX, newY, 1, pixels.getPixel(i, j));
      }
    }

    pixels.dispose();
  }
}
