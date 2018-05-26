import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/models/clipped_polygon_build_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class ClippedPolygonBuildWidget extends Widget {
  StackContainer _root;
  InputBox _leftBorder;
  InputBox _upBorder;
  InputBox _rightBorder;
  InputBox _downBorder;
  IconButton _button;

  ClippedPolygonBuildModel _model;

  ClippedPolygonBuildWidget(ClippedPolygonBuildModel model) {
    _model = model;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.VERTICAL;
    _leftBorder = new InputBox();
    _upBorder = new InputBox();
    _rightBorder = new InputBox();
    _downBorder = new InputBox();
    _button = new IconButton(Icons['accept']);

    _leftBorder.label = "left border";
    _leftBorder.type = "number";
    _leftBorder.value = "0";
    _upBorder.label = "up border";
    _upBorder.type = "number";
    _upBorder.value = "0";
    _rightBorder.label = "right border";
    _rightBorder.type = "number";
    _rightBorder.value = "0";
    _downBorder.label = "down border";
    _downBorder.type = "number";
    _downBorder.value = "0";

    _root.add(_leftBorder.node);
    _root.add(_upBorder.node);
    _root.add(_rightBorder.node);
    _root.add(_downBorder.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var addPointEvents = new WidgetEvents(_model.bitmap.canvas);
    addPointEvents.events['click'] = _addPointEvent;
    actions['addPoint'] = addPointEvents;

    var updateEvents = new WidgetEvents(_button.node);
    updateEvents.events['click'] = _updateBorder;
    actions['update'] = updateEvents;
  }

  void _addPointEvent(Event event) {
    _model.addPoint(event as MouseEvent);
  }

  void _updateBorder(Event event) {
    _model.border.left = num.parse(_leftBorder.value);
    _model.border.up = num.parse(_upBorder.value);
    _model.border.right = num.parse(_rightBorder.value);
    _model.border.down = num.parse(_downBorder.value);
  }

  @override
  HtmlElement get node => _root.node;
}
