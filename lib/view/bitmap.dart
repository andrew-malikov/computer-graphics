import 'dart:html';

import 'package:GraphicsApp/data/color.dart';
import 'package:GraphicsApp/math/point.dart';
import 'package:GraphicsApp/view/pixels.dart';

class Bitmap {
  CanvasElement _canvas;
  CanvasRenderingContext2D _context;

  Bitmap(int width, int height) {
    canvas = new CanvasElement(width: width, height: height);
    _context = canvas.getContext('2d');
  }

  void setPixel(num x, num y, num size, Color color) {
    setRawPixel(x, y, size, color.toRGBString());
  }

  void setRawPixel(num x, num y, num size, String color) {
    context.fillStyle = color;
    context.fillRect(x, y, size, size);
  }

  void drawLine(num x1,num y1,num x2,num y2,num width,String color) {
    context.strokeStyle = color;
    context.lineWidth = width;
    context.beginPath();
    context.moveTo(x1, y1);
    context.lineTo(x2, y2);
    context.stroke();
  }

  Color getPixel(num x, num y, num size) {
    ImageData data = context.getImageData(x, y, size, size);
    return ColorBuilder.RGB(data.data[0], data.data[1], data.data[2]);
  }

  Pixels<T> getPixels<T>(
      num x, num y, num width, num height, DataToColor<T> converter) {
    var imageData = context.getImageData(x, y, width, height);
    var pixels = new Pixels<T>(imageData, converter);
    return pixels;
  }

  Pixels<T> getAllPixels<T>(DataToColor<T> converter) {
    return getPixels(0, 0, width, height, converter);
  }

  void fillAll(Color color) {
    fillArea(0, 0, canvas.width, canvas.height, color);
  }

  void fillArea(num x, num y, num width, num height, Color color) {
    context.fillStyle = color.toRGBAHexString();
    context.fillRect(x, y, width, height);
  }

  void clearAll() {
    context.clearRect(0, 0, canvas.width, canvas.height);
  }

  void clearArea(num x, num y, num width, num height) {
    context.clearRect(x, y, width, height);
  }

  void resize(int width, int height) {
    canvas.width = width;
    canvas.height = height;
  }

  bool containPoint(num x, num y) {
    return canvas.width > x && canvas.height > y && x >= 0 && y >= 0;
  }

  Point2D computePoint(MouseEvent event) {
    Rectangle<num> border = canvas.getBoundingClientRect();
    return new Point2D(
        event.client.x - border.left, event.client.y - border.top);
  }

  Point2D computeDecartPoint(MouseEvent event) {
    Rectangle<num> border = canvas.getBoundingClientRect();
    var x = event.client.x - border.left - width / 2;
    var y = -(event.client.y - border.top) + height / 2;
    return new Point2D(x, y);
  }

  CanvasElement get canvas => _canvas;
  void set canvas(CanvasElement canvas) {
    _canvas = canvas;
    _canvas.classes.add('bitmap');
    _context = canvas.getContext('2d');
  }

  CanvasRenderingContext2D get context => _context;

  num get width => canvas.width;
  num get height => canvas.height;
}
