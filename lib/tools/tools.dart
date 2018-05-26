import 'Package:GraphicsApp/interfaces/i_observable.dart';
import 'Package:GraphicsApp/interfaces/i_observer.dart';
import 'Package:GraphicsApp/tools/tool.dart';

class TransmittedMessage {
  TransmittedState _state;
  Tool _tool;

  TransmittedMessage(TransmittedState state, Tool tool) {
    _state = state;
    _tool = tool;
  }

  TransmittedState get state => _state;
  Tool get tool => _tool;
}

enum TransmittedState { Add, Remove, Set }

class Tools implements IObservable {
  List<IObserver> _observers;
  List<Tool> _tools;
  Tool _currentTool;

  Tools() {
    _tools = new List<Tool>();
    _observers = new List<IObserver>();
  }

  void addTool(Tool tool) {
    list.add(tool);
    NotifyObservers(new TransmittedMessage(TransmittedState.Add, tool));
  }

  bool removeTool(Tool tool) {
    bool result = list.remove(tool);
    if (isCurrentTool(tool)) {
      currentTool = null;
      NotifyObservers(new TransmittedMessage(TransmittedState.Set, tool));
    }
    if (result)
      NotifyObservers(new TransmittedMessage(TransmittedState.Remove, tool));
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
  void NotifyObservers(Object object) {
    for (IObserver observer in _observers) {
      observer.Update(object);
    }
  }

  void set currentTool(Tool tool) {
    if (!list.contains(tool)) return;
    TransmittedMessage message =
        new TransmittedMessage(TransmittedState.Set, currentTool);
    _currentTool = tool;
    NotifyObservers(message);
  }

  Tool get currentTool => _currentTool;

  bool hasCurrentTool() => currentTool != null;
  bool isCurrentTool(Tool tool) => tool == currentTool;

  List<Tool> get list => _tools;
}
