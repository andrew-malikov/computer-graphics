import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/algorithms/basic_transformations.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class ScaleTransformWidget extends Widget {
  StackContainer _root;
  InputBox _scaleX;
  InputBox _scaleY;
  IconButton _button;
  PolygonsModel _polygons;

  ScaleTransformWidget(PolygonsModel polygons) {
    _polygons = polygons;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.VERTICAL;
    _scaleX = new InputBox();
    _scaleY = new InputBox();
    _button = new IconButton(Icons['accept']);

    _scaleX.label = "scale X";
    _scaleX.type = "number";
    _scaleX.value = "1";
    _scaleY.label = "scale Y";
    _scaleY.type = "number";
    _scaleY.value = "1";

    _root.add(_scaleX.node);
    _root.add(_scaleY.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var transformEvents = new WidgetEvents(_button.node);
    transformEvents.events['click'] = _transform;
    actions['transform'] = transformEvents;
  }

  void _transform(Event event) {
    var scaleX = num.parse(_scaleX.value);
    var scaleY = num.parse(_scaleY.value);
    localXYScale(_polygons.values, scaleX, scaleY);
    _polygons.notifyObservers();
  }

  @override
  HtmlElement get node => _root.node;
}
