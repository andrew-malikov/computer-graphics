import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/algorithms/basic_transformations.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class ProjectionTransformWidget extends Widget {
  StackContainer _root;
  InputBox _projectionX;
  InputBox _projectionY;
  IconButton _button;
  PolygonsModel _polygons;

  ProjectionTransformWidget(PolygonsModel polygons) {
    _polygons = polygons;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.VERTICAL;
    _projectionX = new InputBox();
    _projectionY = new InputBox();
    _button = new IconButton(Icons['accept']);

    _projectionX.label = "projection X";
    _projectionX.type = "number";
    _projectionX.value = "0";
    _projectionY.label = "projection Y";
    _projectionY.type = "number";
    _projectionY.value = "0";

    _root.add(_projectionX.node);
    _root.add(_projectionY.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var transformEvents = new WidgetEvents(_button.node);
    transformEvents.events['click'] = _transform;
    actions['transform'] = transformEvents;
  }

  void _transform(Event event) {
    var projectionX = num.parse(_projectionX.value);
    var projectionY = num.parse(_projectionY.value);
    projection(_polygons.values, projectionX, projectionY);
    _polygons.notifyObservers();
  }

  @override
  HtmlElement get node => _root.node;
}
