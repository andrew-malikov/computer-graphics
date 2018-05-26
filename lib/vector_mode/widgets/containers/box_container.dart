import 'dart:html';
import 'package:GraphicsApp/vector_mode/widgets/containers/container.dart';

class BoxContainer extends Container {
  DivElement _root;

  BoxContainer() {
    _root = new DivElement();
    _setUpContainer();
  }

  void _setUpContainer() {
    _root.classes.add("box");
  }

  set content(HtmlElement element) {
    _root.children.clear();
    _root.append(element);
  }

  @override
  HtmlElement get node => _root;
}
