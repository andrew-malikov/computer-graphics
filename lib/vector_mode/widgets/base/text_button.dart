import 'dart:html';

import 'package:GraphicsApp/vector_mode/widgets/base/button.dart';

class TextButton extends Button {
  TextButton(String text) {
    content = new ParagraphElement()..text = text;
  }
}
