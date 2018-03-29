import 'package:TestCG/interfaces/i_observer.dart';
import 'package:TestCG/tools/tool.dart';
import 'package:TestCG/view/layer.dart';

import 'package:TestCG/tools/tools.dart';

class DrawManager implements IObserver {
  Tools _tools;
  Layer _layer;
  Tool _currentTool;

  DrawManager(Tools tools) {
    _tools = tools;
    _tools.addObserver(this);
  }

  void addTool(Tool tool) {
    _tools.addTool(tool);
  }

  bool removeTool(Tool tool) {
    if (isCurrentTool(tool)) tool.removeEvents();
    return _tools.removeTool(tool);
  }

  void set layer(Layer layer) {
    if (hasCurrentTool()) currentTool.layer = layer;
    _layer = layer;
  }

  Layer get layer => _layer;

  void set currentTool(Tool tool) {
    if (!_tools.list.contains(tool)) return;
    if (hasCurrentTool()) currentTool.unsetLayer();
    tool.layer = layer;
    currentTool = tool;
  }

  Tool get currentTool => _currentTool;

  @override
  void Update(Object object) {
    if (_tools.list.contains(object as Tool)) return;
    if (isCurrentTool(object as Tool)) {
      currentTool.unsetLayer();
      currentTool = null;
    }
  }

  bool hasCurrentTool() => currentTool != null;
  bool isCurrentTool(Tool tool) => tool == currentTool;
}
