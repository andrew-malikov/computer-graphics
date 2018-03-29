import '../view/layer.dart';
import '../data/icons.dart';

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

  ToolMetadata get metadata => _metadata;

  Layer get layer => _layer;
  void set layer(Layer layer) {
    if(_layer != null) removeEvents();
    _layer = layer;
    if (layer != null) addEvents();
  }
}
