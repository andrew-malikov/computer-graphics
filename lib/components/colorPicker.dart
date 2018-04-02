import 'dart:html';

import 'package:GraphicsApp/data/color.dart';

class ColorPicker {
  InputElement _root;
  Color _color;

  ColorPicker() {
    _color = ColorBuilder.FullRGBHex("#000");
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new InputElement();
    _root.type = 'color';
    _root.classes.add('color-picker');
    _root.classes.add('button');
    _root.addEventListener('change', _onChange);
  }

  void _onChange(Event event) {
    Color updatedColor = ColorBuilder.FullRGBHex(_root.value);
    color.update(updatedColor);
  }

  InputElement get render => _root;

  Color get color => _color;
}
