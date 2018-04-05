import 'dart:html';

import 'package:GraphicsApp/data/color.dart';

class Bitmap {
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;

  Bitmap(int width, int height) {
    canvas = new CanvasElement(width: width, height: height);
    _context = canvas.getContext('2d');
  }

  void setPixel(num x, num y, num size, Color color) {
    context.fillStyle = color.toRGBString();
    context.fillRect(x, y, size, size);
  }

  Color getPixel(num x, num y, num size) {
    ImageData data = context.getImageData(x, y, size, size);
    return ColorBuilder.RGB(data.data[0], data.data[1], data.data[2]);
  }

  void fill(Color color) {
    context.fillStyle = color.toRGBAString();
    context.fillRect(0, 0, canvas.width, canvas.height);
  }

  void clear() {
    context.clearRect(0, 0, canvas.width, canvas.height);
  }

  void resize(int width, int height) {
    canvas.width = width;
    canvas.height = height;
  }

  bool containPoint(num x, num y) {
    return canvas.width > x && canvas.height > y && x >= 0 && y >= 0;
  }

  CanvasElement get canvas => _canvas;
  void set canvas(CanvasElement canvas) {
    _canvas = canvas;
    _canvas.classes.add('bitmap');
    _context = canvas.getContext('2d');
  }

  CanvasRenderingContext2D get context => _context;
}
