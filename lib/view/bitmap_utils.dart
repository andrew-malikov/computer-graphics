import 'package:GraphicsApp/view/bitmap.dart';

class BitmapUtils {
  Bitmap _bitmap;

  BitmapUtils(Bitmap bitmap) {
    this.bitmap = bitmap;
  }

  List<int> getHorizontalLine(num y) {
    return bitmap.context.getImageData(0, y, bitmap.width, 1).data.toList();
  }

  List<int> getTruncatedHorizontalLine(num startX, num endX, num y) {
    return bitmap.context
        .getImageData(startX, y, endX - startX, 1)
        .data
        .toList();
  }

  Bitmap get bitmap => _bitmap;
  void set bitmap(value) {
    if (value == null) throw new NullThrownError();
    _bitmap = value;
  }
}
