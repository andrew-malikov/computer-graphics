import 'dart:html';

import 'package:GraphicsApp/vector_mode/widgets/i_viewable.dart';

class Button implements IViewable {
  ButtonElement _root;

  Button() {
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new ButtonElement();
    _root.classes.add('button');
  }

  set content(HtmlElement element) {
    _root.append(element);
  }

  void removeContent() {
    _root.children.clear();
  }

  @override
  HtmlElement get node => _root;
}
