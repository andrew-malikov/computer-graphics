import 'dart:html';

import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/icon_button.dart';
import 'package:GraphicsApp/vector_mode/widgets/containers/stack_container.dart';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class ToolsWidget extends Widget {
  StackContainer _root;
  StackContainer _buttons;
  DivElement _content;
  List<Widget> _tools;
  Widget _currentTool;

  ToolsWidget() {
    _root = new StackContainer();
    _buttons = new StackContainer();
    _content = new DivElement();
    _tools = new List();
    _currentTool = null;
    _setUpWidget();
  }

  void _setUpWidget() {
    _root.add(_buttons.node);
    _root.add(new HRElement());
    _root.add(_content);

    _root.orientation = ContainerOrientation.VERTICAL;
    _buttons.orientation = ContainerOrientation.HORIZONTAL;
  }

  void addTool(Widget widget, Icon icon) {
    var button = new IconButton(icon);
    button.node.addEventListener('click', (Event event) {
      selectTool(widget);
    });

    _buttons.add(button.node);
    _tools.add(widget);
  }

  void selectTool(Widget widget) {
    if (!_tools.contains(widget)) return;
    _disableCurrentTool();
    widget.enable();
    _updateContent(widget.node);
    _currentTool = widget;
  }

  void _disableCurrentTool() {
    if (_currentTool == null) return;
    _currentTool.disable();
  }

  void _updateContent(HtmlElement element) {
    _content.children.clear();
    _content.append(element);
  }

  @override
  HtmlElement get node => _root.node;
}
