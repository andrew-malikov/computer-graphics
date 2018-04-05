import 'dart:html';

import 'Package:GraphicsApp/data/icons.dart';
import 'Package:GraphicsApp/view/layer.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/view/bitmap.dart';

class ToolMetadata {
  String _name;
  Icon _icon;

  ToolMetadata(String name, Icon icon) {
    _name = name;
    _icon = icon;
  }

  String get name => _name;
  Icon get icon => _icon;
}

typedef void ToolEvent(Event event);

abstract class Tool {
  ToolMetadata _metadata;
  Layer _layer;
  Map<String, ToolEvent> _events;

  Tool(ToolMetadata metadata) {
    _metadata = metadata;
    _events = new Map<String, ToolEvent>();
    registrateEvents();
  }

  /// Called in the constructor to register events
  void registrateEvents();

  void addEvents() {
    for (String key in _events.keys)
      layer.preview.canvas.addEventListener(key, _events[key]);
  }

  void removeEvents() {
    for (String key in _events.keys)
      layer.preview.canvas.removeEventListener(key, _events[key]);
  }

  void unsetLayer() {
    layer = null;
  }

  ToolMetadata get metadata => _metadata;

  Layer get layer => _layer;
  void set layer(Layer layer) {
    if (_layer != null) removeEvents();
    _layer = layer;
    if (layer != null) addEvents();
  }

  bool hasLayer() => layer != null;

  Map<String, ToolEvent> get events => _events;
}

Point2D computePoint(MouseEvent event, Bitmap bitmap) {
  Rectangle<num> border = bitmap.canvas.getBoundingClientRect();
  return new Point2D(event.client.x - border.left, event.client.y - border.top);
}
