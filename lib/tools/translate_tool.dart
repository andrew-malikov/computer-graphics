import 'dart:html';

import 'package:GraphicsApp/algorithms/translate.dart';
import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/tools/tool.dart';

enum State { SetStartBorder, SetEndBorder, SetMovePoint }

class TranslateTool extends Tool {
  Translate _tool;
  State _state;
  Point2D _startBorder;
  Point2D _size;

  TranslateTool(Translate tool)
      : super(new ToolMetadata('translate', Icons['move'])) {
    this.tool = tool;
    _state = State.SetStartBorder;
  }

  @override
  void registrateEvents() {
    events['click'] = _click;
  }

  void _click(Event event) {
    window.requestAnimationFrame((time) {
      switch (state) {
        case State.SetStartBorder:
          _startBorder = computePoint(event, layer.body);
          _nextState();
          break;
        case State.SetEndBorder:
          _size = computePoint(event, layer.body) - _startBorder;
          _nextState();
          break;
        case State.SetMovePoint:
          var point = computePoint(event, layer.body);
          var movingValue = point - (_startBorder + (_size / 2));
          tool.execute(layer.body, _startBorder, _size, movingValue);
          _nextState();
      }
    });
  }

  void _nextState() {
    switch (state) {
      case State.SetStartBorder:
        _state = State.SetEndBorder;
        break;
      case State.SetEndBorder:
        _state = State.SetMovePoint;
        break;
      case State.SetMovePoint:
        _state = State.SetStartBorder;
        break;
    }
  }

  Translate get tool => _tool;
  void set tool(Translate tool) => _tool = tool;

  State get state => _state;
}
