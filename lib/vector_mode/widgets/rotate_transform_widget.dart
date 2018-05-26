import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/algorithms/basic_transformations.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class RotateTransformWidget extends Widget {
  StackContainer _root;
  InputBox _angle;
  IconButton _button;
  PolygonsModel _polygons;

  RotateTransformWidget(PolygonsModel polygons) {
    _polygons = polygons;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.HORIZONTAL;
    _angle = new InputBox();
    _button = new IconButton(Icons['accept']);

    _angle.label = "angle";
    _angle.type = "number";
    _angle.value = "0";

    _root.add(_angle.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var transformEvents = new WidgetEvents(_button.node);
    transformEvents.events['click'] = _transform;
    actions['transform'] = transformEvents;
  }

  void _transform(Event event) {
    var angle = num.parse(_angle.value);
    rotate(_polygons.values, angle);
    _polygons.notifyObservers();
  }

  @override
  HtmlElement get node => _root.node;
}
