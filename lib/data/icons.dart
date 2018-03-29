import 'dart:html';

class Icon {
  String _name;
  String _link;
  int _size;

  Icon(String name, String link, int size) {
    _name = name;
    _link = link;
    _size = size;
  }

  ImageElement render() {
    ImageElement icon = new ImageElement();
    icon.src = link;
    icon.width = size;
    icon.height = size;
    return icon;
  }

  String get name => _name;
  String get link => _link;
  int get size => _size;
}

Map<String, Icon> Icons = {
  'line': new Icon('line', 'resources/Paint/line_01.svg', 32),
  'circle': new Icon('circle', 'resources/Paint/circle_01.svg', 32)
};
