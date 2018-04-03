import 'dart:html';

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

  bool hasLayer() => layer != null;
}
