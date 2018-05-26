import 'dart:html';

import 'package:GraphicsApp/vector_mode/widgets/containers/container.dart';

enum ContainerOrientation { VERTICAL, HORIZONTAL }

class StackContainer extends Container {
  DivElement _root;

  StackContainer() {
    _root = new DivElement();
  }

  void add(HtmlElement element) {
    _root.append(element);
  }

  void remove(HtmlElement element) {
    _root.children.remove(element);
  }

  set orientation(ContainerOrientation value) {
    switch (value) {
      case ContainerOrientation.HORIZONTAL:
        _replaceCssClass("vertical-container", "horizontal-container");
        break;
      case ContainerOrientation.VERTICAL:
        _replaceCssClass("horizontal-container", "vertical-container");
        break;
    }
  }

  void _replaceCssClass(String oldClass, String newClass) {
    _root.classes.removeWhere((cssClass) => cssClass == oldClass);
    _root.classes.add(newClass);
  }

  @override
  HtmlElement get node => _root;
}
