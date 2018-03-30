import 'Package:GraphicsApp/interfaces/i_observable.dart';
import 'Package:GraphicsApp/interfaces/i_observer.dart';
import 'Package:GraphicsApp/tools/tool.dart';

class Tools implements IObserveable {
  List<Tool> _tools;
  List<IObserver> _observers;
  Tool _temporaryTool;

  Tools() {
    _tools = new List<Tool>();
    _observers = new List<IObserver>();
  }

  void addTool(Tool tool) {
    list.add(tool);
    _temporaryTool = tool;
    NotifyObservers();
  }

  bool removeTool(Tool tool) {
    bool result = list.remove(tool);
    _temporaryTool = tool;
    if (result) NotifyObservers();
    return result;
  }

  @override
  void subscribeObserver(IObserver observer) {
    _observers.add(observer);
  }

  @override
  void unsubscribeObserver(IObserver observer) {
    _observers.remove(observer);
  }

  @override
  void NotifyObservers() {
    for (IObserver observer in _observers) {
      observer.Update(_temporaryTool);
    }
  }

  List<Tool> get list => _tools;
}
