import 'Package:GraphicsApp/tools/tool.dart';
import 'package:GraphicsApp/components/button.dart';
import 'package:GraphicsApp/interfaces/i_observer.dart';
import 'package:GraphicsApp/tools/tools.dart';

import 'dart:html';

class Toolbox implements IObserver {
  HtmlElement _root;
  Tools _tools;
  List<Button> _buttons;

  Toolbox(Tools tools) {
    _buttons = new List<Button>();
    _tools = tools;
    _tools.subscribeObserver(this);
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new DivElement();
    for (Tool tool in _tools.list) {
      Button button = new Button(tool.metadata.icon, click);
      buttons.add(button);
      _root.append(button.render);
    }
  }

  void click(Event event) {
    print("${event.timeStamp}");
  }

  HtmlElement get render => _root;

  Tools get tools => _tools;
  List<Button> get buttons => _buttons;

  @override
  void Update(Object object) {
    Tool tool = object as Tool;
    if (!_tools.list.contains(tool)) {
      Button removedButton = buttons.firstWhere((item) {
        item.icon == tool.metadata.icon;
      });
      buttons.remove(removedButton);
      _root.childNodes.remove(removedButton.render);
    } else {
      Button button = new Button(tool.metadata.icon, click);
      buttons.add(button);
      _root.append(button.render);
    }
  }

  void unsubscribe() {
    _tools.unsubscribeObserver(this);
  }
}
