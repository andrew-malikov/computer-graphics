import 'dart:html';

import 'package:GraphicsApp/algorithms/simple_fill.dart';
import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/tools/tool.dart';

class SimpleFillTool extends Tool {
  SimpleFill _tool;

  SimpleFillTool(SimpleFill tool)
      : super(new ToolMetadata('fill', Icons['bucket'])) {
    this.tool = tool;
  }

  @override
  void registrateEvents() {
    events['click'] = _click;
  }

  void _click(Event event) {
    window.requestAnimationFrame((time) {
      Point2D point = computePoint(event as MouseEvent, layer.body);
      tool.draw(layer.body, point);
    });
  }

  SimpleFill get tool => _tool;
  void set tool(SimpleFill tool) => _tool = tool;
}
