import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/view/bitmap.dart';

class GridRender {
  num axisWidth = 1.2;
  num regularWidth = 0.5;
  num subWidth = 0.2;

  Color axisColor = ColorBuilder.FullRGBHex("#3f3f3f");
  Color regualrColor = ColorBuilder.FullRGBHex("#2a3a4a");
  Color subColor = ColorBuilder.FullRGBHex("#6f4f2f");

  void render(Bitmap bitmap) {
    _drawVerticalLines(bitmap, 10, subWidth, subColor);
    _drawVerticalLines(bitmap, 50, regularWidth, regualrColor);

    _drawHorizontalLines(bitmap, 10, subWidth, subColor);
    _drawHorizontalLines(bitmap, 50, subWidth, regualrColor);

    _drawAxis(bitmap);
  }

  void _drawAxis(Bitmap bitmap) {
    var vLine = {'startY': 0, 'endY': bitmap.height, 'x': bitmap.width / 2};

    var hLine = {'startX': 0, 'endX': bitmap.width, 'y': bitmap.height / 2};

    bitmap.drawLine(vLine['x'], vLine['startY'], vLine['x'], vLine['endY'],
        axisWidth, axisColor.toRGBString());

    bitmap.drawLine(hLine['startX'], hLine['y'], hLine['endX'], hLine['y'],
        axisWidth, axisColor.toRGBString());
  }

  void _drawVerticalLines(Bitmap bitmap, num spacing, num width, Color color) {
    var line = {'startY': 0, 'endY': bitmap.height, 'x': bitmap.width / 2};

    for (; line['x'] <= bitmap.width; line['x'] += spacing) {
      bitmap.drawLine(line['x'], line['startY'], line['x'], line['endY'], width,
          color.toRGBString());
    }

    line['x'] = bitmap.width / 2 - spacing;

    for (; line['x'] >= 0; line['x'] -= spacing) {
      bitmap.drawLine(line['x'], line['startY'], line['x'], line['endY'], width,
          color.toRGBString());
    }
  }

  void _drawHorizontalLines(
      Bitmap bitmap, num spacing, num width, Color color) {
    var line = {'startX': 0, 'endX': bitmap.width, 'y': bitmap.height / 2};

    for (; line['y'] <= bitmap.height; line['y'] += spacing) {
      bitmap.drawLine(line['startX'], line['y'], line['endX'], line['y'], width,
          color.toRGBString());
    }

    line['y'] = bitmap.height / 2 - spacing;

    for (; line['y'] >= 0; line['y'] -= spacing) {
      bitmap.drawLine(line['startX'], line['y'], line['endX'], line['y'], width,
          color.toRGBString());
    }
  }
}
