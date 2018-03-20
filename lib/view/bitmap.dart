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
    _context = canvas.getContext('2d');
  }

  CanvasRenderingContext2D get context => _context;
}
