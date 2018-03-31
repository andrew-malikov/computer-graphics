import 'Package:GraphicsApp/view/bitmap.dart';
import 'dart:html';

class Layer {
  HtmlElement _root;
  Bitmap _body;
  Bitmap _preview;

  Layer(int width, int height) {
    body = new Bitmap(width, height);
    preview = new Bitmap(width, height);
    _setUpComponent();
  }

  void _setUpComponent() {
    _root = new DivElement();
    _root.append(body.canvas);
    _root.append(preview.canvas);
    _root.classes.add('layer'); 
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