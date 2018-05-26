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
  'line': new Icon('line', 'resources/Icons/Paint/line_01.svg', 16),
  'segment': new Icon('segment', 'resources/Icons/Paint/segment_01.svg', 16),
  'circle': new Icon('circle', 'resources/Icons/Paint/circle_01.svg', 16),
  'bucket': new Icon('fill', 'resources/Icons/Paint/bucket_01.svg', 16),
  'move': new Icon('move', 'resources/Icons/Paint/move_01.svg', 16),
  'rotate': new Icon('rotate', 'resources/Icons/Transform/rotate_01.svg', 16),
  'scale': new Icon('scale', 'resources/Icons/Transform/scale_01.svg', 16),
  'reflect_x':
      new Icon('reflect_x', 'resources/Icons/Transform/reflect_x_01.svg', 16),
  'reflect_y':
      new Icon('reflect_y', 'resources/Icons/Transform/reflect_y_01.svg', 16),
  'diagonal_reflect': new Icon(
      'diagonal_reflect', 'resources/Icons/Transform/diagonal_reflect.svg', 16),
  'projection':
      new Icon('projection', 'resources/Icons/Transform/projection_01.svg', 16),
  'cancel': new Icon('cancel', 'resources/Icons/Action/cancel_01.svg', 16),
  'accept': new Icon('accept', 'resources/Icons/Action/accept_01.svg', 16)
};
