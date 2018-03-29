import '../view/bitmap.dart';
import '../view/layer.dart';
import '../math/point.dart';
import 'tool.dart';

import 'dart:html';

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
