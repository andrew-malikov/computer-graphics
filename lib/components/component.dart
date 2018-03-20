import '../view/layer.dart';

abstract class Component {
  Layer _layer;

  Component(this._layer) {}

  void addEvents();
  void removeEvents();
  void unsetLayer();

  Layer get layer => _layer;
  void set layer(Layer layer) {
    removeEvents();
    _layer = layer;
    addEvents();
  }
}
