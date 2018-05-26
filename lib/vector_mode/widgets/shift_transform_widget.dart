import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/algorithms/basic_transformations.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class ShiftTransformWidget extends Widget {
  StackContainer _root;
  InputBox _shiftX;
  InputBox _shiftY;
  IconButton _button;
  PolygonsModel _polygons;

  ShiftTransformWidget(PolygonsModel polygons) {
    _polygons = polygons;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.VERTICAL;
    _shiftX = new InputBox();
    _shiftY = new InputBox();
    _button = new IconButton(Icons['accept']);

    _shiftX.label = "shift X";
    _shiftX.type = "number";
    _shiftX.value = "0";
    _shiftY.label = "shift Y";
    _shiftY.type = "number";
    _shiftY.value = "0";

    _root.add(_shiftX.node);
    _root.add(_shiftY.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var transformEvents = new WidgetEvents(_button.node);
    transformEvents.events['click'] = _transform;
    actions['transform'] = transformEvents;
  }

  void _transform(Event event) {
    var shiftX = num.parse(_shiftX.value);
    var shiftY = num.parse(_shiftY.value);
    shift(_polygons.values, shiftX, shiftY);
    _polygons.notifyObservers();
  }

  @override
  HtmlElement get node => _root.node;
}
