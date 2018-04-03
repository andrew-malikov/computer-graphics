import 'dart:html';

import 'Package:GraphicsApp/algorithms/cda_line.dart';
import 'Package:GraphicsApp/algorithms/bresenham_line.dart';
import 'Package:GraphicsApp/algorithms/circle.dart';
import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/tools/line_tool.dart';
import 'Package:GraphicsApp/tools/circle_tool.dart';
import 'Package:GraphicsApp/view/layer.dart';

import 'package:GraphicsApp/algorithms/simple_fill.dart';
import 'package:GraphicsApp/components/colorPicker.dart';
import 'package:GraphicsApp/components/toolbox.dart';
import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/services/draw_manager.dart';
import 'package:GraphicsApp/tools/simple_fill_tool.dart';
import 'package:GraphicsApp/tools/tools.dart';
import 'package:GraphicsApp/components/card.dart';

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
  Layer mainLayer = new Layer(640, 480);

  ColorPicker colorPicker = new ColorPicker();

  LineTool cdaLine = new LineTool(new CDALine(colorPicker.color, 1));
  LineTool bresenhamLine =
      new LineTool(new BresenhamLine(colorPicker.color, 1));

  CircleTool circle = new CircleTool(new Circle(colorPicker.color, 1));

  SimpleFillTool fillTool =
      new SimpleFillTool(new SimpleFill(colorPicker.color));

  Tools tools = new Tools();
  Toolbox toolbox = new Toolbox(tools);

  tools.addTool(cdaLine);
  tools.addTool(bresenhamLine);
  tools.addTool(circle);
  tools.addTool(fillTool);

  CardComponent toolsCard = new CardComponent("Tools", toolbox.render);
  CardComponent colorPickerCard =
      new CardComponent("ColorPicker", colorPicker.render);

  DrawManager manager = new DrawManager(tools);
  manager.layer = mainLayer;

  document.querySelector('#mainFrame').append(toolsCard.render);
  document.querySelector('#mainFrame').append(mainLayer.render);
  document.querySelector('#mainFrame').append(colorPickerCard.render);
}
