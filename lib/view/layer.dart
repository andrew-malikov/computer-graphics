import 'Package:GraphicsApp/view/bitmap.dart';

class Layer {
  Bitmap _body;
  Bitmap _preview;

  Layer(int width, int height) {
    body = new Bitmap(width, height);
    preview = new Bitmap(width, height);
  }

  void resize(int width, int height) {
    body.resize(width, height);
    preview.resize(width, height);
  }

  Bitmap get body => _body;
  void set body(Bitmap bitmap) => _body = bitmap;

  Bitmap get preview => _preview;
  void set preview(Bitmap bitmap) => _preview = bitmap;
}