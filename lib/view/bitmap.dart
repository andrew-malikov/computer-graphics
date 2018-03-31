import 'dart:html';

class Bitmap {
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;

  Bitmap(int width, int height) {
    canvas = new CanvasElement(width: width, height: height);
    _context = canvas.getContext('2d');
  }

  void setPixel(int x, int y, int size, String color) {
    context.fillStyle = color;
    context.fillRect(x, y, size, size);
  }

  String getPixel(int x, int y, int size) {
    ImageData data = context.getImageData(x, y, size, size);
    return "rgba(${data.data[0]},${data.data[1]},${data.data[2]},${data.data[3]})";
  }

  void clear() {
    context.clearRect(0, 0, canvas.width, canvas.height);
  }

  void resize(int width, int height) {
    canvas.width = width;
    canvas.height = height;
  }

  CanvasElement get canvas => _canvas;
  void set canvas(CanvasElement canvas) {
    _canvas = canvas;
    _canvas.classes.add('bitmap');
    _context = canvas.getContext('2d');
  }

  CanvasRenderingContext2D get context => _context;
}
