import 'dart:html';

import 'Package:GraphicsApp/view/bitmap.dart';
import 'package:GraphicsApp/data/color.dart';

class Layer {
  HtmlElement _root;
  Bitmap _body;
  Bitmap _preview;

  Layer(int width, int height) {
    body = new Bitmap(width, height);
    body.fillAll(DefaultColors['white']);
    preview = new Bitmap(width, height);
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new DivElement();
    _root.append(preview.canvas);
    _root.append(body.canvas);
    _root.classes.add('layer');
    body.canvas.classes.add('body');
    preview.canvas.classes.add('preview');
  }

  void resize(int width, int height) {
    body.resize(width, height);
    preview.resize(width, height);
  }

  Bitmap get body => _body;
  void set body(Bitmap bitmap) => _body = bitmap;

  Bitmap get preview => _preview;
  void set preview(Bitmap bitmap) => _preview = bitmap;

  HtmlElement get render => _root;
}
