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

abstract class Tool {
  ToolMetadata _metadata;
  Layer _layer;

  Tool(ToolMetadata metadata) {
    _metadata = metadata;
  }

  void addEvents();
  void removeEvents();
  void unsetLayer() {
    layer = null;
  }

  Point2D computePoint(MouseEvent event, Bitmap bitmap) {
    Rectangle<num> border = bitmap.canvas.getBoundingClientRect();
    return new Point2D(
        event.client.x - border.left, event.client.y - border.top);
  }

  ToolMetadata get metadata => _metadata;

  Layer get layer => _layer;
  void set layer(Layer layer) {
    if (_layer != null) removeEvents();
    _layer = layer;
    if (layer != null) addEvents();
  }
}
