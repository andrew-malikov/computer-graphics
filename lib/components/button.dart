import 'dart:html';
import 'package:GraphicsApp/data/icons.dart';

class Button {
  String _id;
  Icon _icon;
  EventListener _action;
  ButtonElement _root;

  Button(Icon icon, EventListener action) {
    _id = '${icon.name}-button';
    _icon = icon;
    _action = action;
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new ButtonElement();
    _root.append(icon.render());
    _root.addEventListener('click', _action);
    _root.id = id;
  }

  ButtonElement get render => _root;

  String get id => _id;
  Icon get icon => _icon;
}
