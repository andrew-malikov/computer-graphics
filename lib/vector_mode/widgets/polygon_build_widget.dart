import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/models/polygon_build_model.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class PolygonBuildWidget extends Widget {
  StackContainer _root;
  IconButton _build;
  IconButton _removeLast;

  PolygonBuildModel _model;

  PolygonBuildWidget(PolygonBuildModel model) {
    _root = new StackContainer();
    _model = model;
    _setUpWidget();
  }

  void _setUpWidget() {
    _build = new IconButton(Icons['accept']);
    _removeLast = new IconButton(Icons['cancel']);

    _root.add(_build.node);
    _root.add(_removeLast.node);
    _root.orientation = ContainerOrientation.HORIZONTAL;

    _registrateEvents();
  }

  void _registrateEvents() {
    var addPointEvents = new WidgetEvents(_model.bitmap.canvas);
    addPointEvents.events['click'] = _addPointEvent;
    actions['addPoint'] = addPointEvents;

    var buildEvents = new WidgetEvents(_build.node);
    buildEvents.events['click'] = _buildPolygonEvent;
    actions['build'] = buildEvents;

    var removeLastEvents = new WidgetEvents(_removeLast.node);
    removeLastEvents.events['click'] = _removeLastPointEvent;
    actions['removeLast'] = removeLastEvents;
  }

  void _addPointEvent(Event event) {
    _model.addPoint(event as MouseEvent);
  }

  void _buildPolygonEvent(Event event) {
    _model.build();
  }

  void _removeLastPointEvent(Event event) {
    _model.removeLastPoint();
  }

  @override
  HtmlElement get node => _root.node;
}
