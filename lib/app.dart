import 'dart:html';

import 'Package:GraphicsApp/algorithms/cda_line.dart';
import 'Package:GraphicsApp/algorithms/bresenham_line.dart';
import 'Package:GraphicsApp/algorithms/circle.dart';
import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/tools/line_tool.dart';
import 'Package:GraphicsApp/tools/circle_tool.dart';
import 'Package:GraphicsApp/view/layer.dart';

class Application {
  List<Tool> _components;
  List<Layer> _layers;
  Tool _currentTool;
  Layer _currentLayer;

  Application() {
    _components = new List<Tool>();
    _layers = new List<Layer>();
  }

  void addComponent(Tool component) {
    if (!_components.contains(component)) _components.add(component);
  }

  void removeComponent(Tool component) {
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

  Tool get currentTool => _currentTool;
  void set currentTool(Tool component) {
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

  LineTool cdaLine = new LineTool(new CDALine('#71b2b2', 1));
  LineTool bresenhamLine = new LineTool(new BresenhamLine('#f2b271', 1));

  Circle circle = new Circle('#336655', 1);
  CircleTool circleComponent = new CircleTool(circle);

  // circle.draw(mainLayer.body, new Segment(new Point2D(50, 50), new Point2D(60, 60)));

  app.addLayer(mainLayer);
  app.addComponent(bresenhamLine);
  app.addComponent(cdaLine);
  app.addComponent(circleComponent);

  app.currentLayer = mainLayer;
  app.currentTool = bresenhamLine;
}
