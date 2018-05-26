import 'package:GraphicsApp/data/icons.dart';
import 'package:GraphicsApp/vector_mode/widgets/base/button.dart';

class IconButton extends Button {
  IconButton(Icon icon) {
    content = icon.render();
  }
}
