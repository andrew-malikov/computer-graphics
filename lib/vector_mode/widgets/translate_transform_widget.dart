import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/algorithms/basic_transformations.dart';
import 'package:GraphicsApp/vector_mode/models/polygons_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/input_box.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class TranslateTransformWidget extends Widget {
  StackContainer _root;
  InputBox _translateX;
  InputBox _translateY;
  IconButton _button;
  PolygonsModel _polygons;

  TranslateTransformWidget(PolygonsModel polygons) {
    _polygons = polygons;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root = new StackContainer()..orientation = ContainerOrientation.VERTICAL;
    _translateX = new InputBox();
    _translateY = new InputBox();
    _button = new IconButton(Icons['accept']);

    _translateX.label = "translate X";
    _translateX.type = "number";
    _translateX.value = "0";
    _translateY.label = "translate Y";
    _translateY.type = "number";
    _translateY.value = "0";

    _root.add(_translateX.node);
    _root.add(_translateY.node);
    _root.add(_button.node);

    _registrateEvents();
  }

  void _registrateEvents() {
    var transformEvents = new WidgetEvents(_button.node);
    transformEvents.events['click'] = _transform;
    actions['transform'] = transformEvents;
  }

  void _transform(Event event) {
    var translateX = num.parse(_translateX.value);
    var translateY = num.parse(_translateY.value);
    translate(_polygons.values, translateX, translateY);
    _polygons.notifyObservers();
  }

  @override
  HtmlElement get node => _root.node;
}
