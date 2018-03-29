import 'dart:html';

import 'Package:GraphicsApp/view/bitmap.dart';
import 'Package:GraphicsApp/view/layer.dart';
import 'Package:GraphicsApp/math/point.dart';
import 'Package:GraphicsApp/tools/tool.dart';

enum State { SetStartPoint, SetEndPoint }

abstract class BaseTool extends Tool {
  BaseTool(ToolMetadata metadata) : super(metadata) {}

  void addEvents() {
    if (!hasLayer()) return;
    layer.body.canvas.addEventListener('click', click);
    layer.body.canvas.addEventListener('mousemove', move);
  }

  void removeEvents() {
    if (!hasLayer()) return;
    layer.body.canvas.removeEventListener('click', click);
    layer.body.canvas.removeEventListener('mousemove', move);
  }

  void click(Event event);

  void move(Event event);

  Point2D computePoint(MouseEvent event, Bitmap bitmap) {
    Rectangle<num> border = bitmap.canvas.getBoundingClientRect();
    return new Point2D(
        event.client.x - border.left, event.client.y - border.top);
  }

  bool hasLayer() => layer != null;
}
