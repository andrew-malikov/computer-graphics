import 'Package:GraphicsApp/interfaces/i_observer.dart';
import 'Package:GraphicsApp/tools/tool.dart';
import 'Package:GraphicsApp/view/layer.dart';
import 'Package:GraphicsApp/tools/tools.dart';

class DrawManager implements IObserver {
  Tools _tools;
  Layer _layer;

  DrawManager(Tools tools) {
    _tools = tools;
    _tools.subscribeObserver(this);
  }

  void addTool(Tool tool) {
    _tools.addTool(tool);
  }

  bool removeTool(Tool tool) {
    if (_tools.isCurrentTool(tool)) tool.removeEvents();
    return _tools.removeTool(tool);
  }

  void set layer(Layer layer) {
    if (_tools.hasCurrentTool()) _tools.currentTool.layer = layer;
    _layer = layer;
  }

  Layer get layer => _layer;

  void set currentTool(Tool tool) {
    if (!_tools.list.contains(tool)) return;
    if (_tools.hasCurrentTool()) _tools.currentTool.unsetLayer();
    tool.layer = layer;
    _tools.currentTool = tool;
  }

  @override
  void Update(Object object) {
    TransmittedMessage message = object as TransmittedMessage;
    if (message.state == TransmittedState.Set) {
      if (message.tool != null) message.tool.unsetLayer();
      if (_tools.hasCurrentTool()) _tools.currentTool.layer = layer;
      print("Layer is setup");
    }
  }

  void unsubscribe() {
    _tools.unsubscribeObserver(this);
  }
}
