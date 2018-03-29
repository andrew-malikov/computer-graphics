import '../view/bitmap.dart';
import '../view/layer.dart';
import '../algorithms/line.dart';
import '../math/point.dart';
import '../math/segment.dart';
import '../tools/base_tool.dart';
import 'tool.dart';
import '../data/icons.dart';

import 'dart:html';

class LineTool extends BaseTool {
  State _state;
  Point2D _point;
  Line _tool;

  LineTool(Line tool) : super(new ToolMetadata('Line', Icons['line'])) {
    _state = State.SetStartPoint;
    _point = Point2DBuilder.defaultPoint();
    _tool = tool;
  }

  void click(Event event) {
    window.requestAnimationFrame((time) {
      MouseEvent mouseEvent = event as MouseEvent;
      if (state == State.SetStartPoint) {
        _point = computePoint(mouseEvent, layer.body);
        _state = State.SetEndPoint;
      } else {
        Point2D endPoint = computePoint(mouseEvent, layer.body);
        tool.draw(layer.body, new Segment(point, endPoint));
        layer.preview.clear();
        _state = State.SetStartPoint;
      }
    });
  }

  void move(Event event) {
    window.requestAnimationFrame((time) {
      if (_state != State.SetEndPoint) return;
      MouseEvent mouseEvent = event as MouseEvent;
      layer.preview.clear();
      Point2D endPoint = computePoint(mouseEvent, layer.preview);
      tool.draw(layer.preview, new Segment(_point, endPoint));
    });
  }

  Point2D get point => _point;

  Line get tool => _tool;
  void set(Line tool) => _tool = tool;

  State get state => _state;
}
