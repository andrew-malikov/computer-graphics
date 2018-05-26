import 'dart:html';
import 'package:GraphicsApp/vector_mode/widgets/widget.dart';

class InputBox extends Widget {
  InputElement _root;

  InputBox() {
    _root = new InputElement();
    _setUpWidget();
  }

  void _setUpWidget() {
    _root.classes..add('input')..add('width-fit');
  }

  set label(String value) => _root.setAttribute('placeholder', value);
  set type(String value) => _root.setAttribute('type', value);

  String get value => _root.value;
  set value(String value) => _root.value = value;

  @override
  HtmlElement get node => _root;
}
