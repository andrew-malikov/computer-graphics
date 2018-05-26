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
    _root.classes.add('toolbox');
    for (Tool tool in _tools.list) {
      Button button = new Button(tool.metadata.icon, (Event event) {
        click(event, tool);
      });
      buttons.add(button);
      _root.append(button.render);
    }
  }

  void click(Event event, Tool tool) {
    tools.currentTool = tool;
  }

  HtmlElement get render => _root;

  Tools get tools => _tools;
  List<Button> get buttons => _buttons;

  @override
  void Update(Object object) {
    TransmittedMessage message = object as TransmittedMessage;
    if (message.state == TransmittedState.Add) {
      Button button = new Button(message.tool.metadata.icon, (Event event) {
        click(event, message.tool);
      });
      buttons.add(button);
      _root.append(button.render);
    } else if (message.state == TransmittedState.Remove) {
      Button removedButton = buttons.firstWhere((item) {
        item.icon == message.tool.metadata.icon;
      });
      buttons.remove(removedButton);
      _root.children.remove(removedButton.render);
    }
  }

  void unsubscribe() {
    _tools.unsubscribeObserver(this);
  }
}
