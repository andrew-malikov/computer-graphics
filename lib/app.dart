import 'dart:html';

import './math/point.dart';
import './math/segment.dart';
import './view/bitmap.dart';
import './tools/cda_line.dart';
import './tools/bresenham_line.dart';

import './tools/line.dart';
import './components/component.dart';
import './components/line_component.dart';
import './view/layer.dart';


class Application {
  List<Component> _components;
  List<Layer> _layers;
  Component _currentTool;
  Layer _currentLayer;

  Application() {
    _components = new List<Component>();
    _layers = new List<Layer>();
  }

  void addComponent(Component component) {
    if (!_components.contains(component)) _components.add(component);
  }

  void removeComponent(Component component) {
    if (!_components.contains(component)) return;
    if (currentTool == component) currentTool = null;
    component.unsetLayer();
    _components.remove(component);
  }

  void addLayer(Layer layer) {
    if (!_layers.contains(layer)) _layers.add(layer);
  }

  void removeLayer(Layer layer) {
    if (!_layers.contains(layer)) return;
    if (currentLayer == layer) _unsetCurrentLayer();
    _layers.remove(layer);
  }

  void _unsetCurrentLayer() {
    if (currentTool == null) return;
    currentTool.unsetLayer();
  }

  Component get currentTool => _currentTool;
  void set currentTool(Component component) {
    if (!_components.contains(component)) return;
    if (hasCurrentTool()) currentTool.unsetLayer();
    component.layer = currentLayer;
    _currentTool = component;
  }

  Layer get currentLayer => _currentLayer;
  void set currentLayer(Layer layer) {
    if (!_layers.contains(layer)) return;
    if (hasCurrentTool()) currentTool.layer = layer;
    _currentLayer = layer;
  }

  bool hasCurrentTool() => currentTool != null;
}

void initializeApp() {
  Application app = new Application();

  Layer mainLayer = new Layer(640, 480);
  mainLayer.body.canvas.style.zIndex = '3';
  document.body.append(mainLayer.body.canvas);
  document.body.append(mainLayer.preview.canvas);

  LineComponent cdaLine = new LineComponent(new CDALine('#71b2b2', 1));
  LineComponent bresenhamLine =
      new LineComponent(new BresenhamLine('#f2b271', 1));

  app.addLayer(mainLayer);
  app.addComponent(bresenhamLine);
  app.addComponent(cdaLine);

  app.currentLayer = mainLayer;
  app.currentTool = cdaLine;
}
