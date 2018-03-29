import 'dart:html';

import 'tool.dart';
import 'base_tool.dart';
import '../algorithms/circle.dart';

import '../view/bitmap.dart';

import '../math/point.dart';
import '../math/segment.dart';

import '../data/icons.dart';

class CircleTool extends BaseTool {
  State _state;
  Point2D _point;
  Circle _tool;

  CircleTool(Circle tool) : super(new ToolMetadata('circle', Icons['circle'])) {
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

  State get state => _state;

  Point2D get point => _point;

  Circle get tool => _tool;
  void set(Circle tool) => _tool = tool;
}
