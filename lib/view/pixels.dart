import 'dart:html';

typedef T DataToColor<T>(List<int> data);

class Pixels<T> {
  List<T> _pixels;
  int _width;
  int _height;

  Pixels(ImageData imageData, DataToColor<T> converter) {
    _pixels = _unboxImageData(imageData, converter);
    _width = imageData.width;
    _height = imageData.height;
  }

  List<Object> _unboxImageData(ImageData imageData, DataToColor<T> converter) {
    var pixels = new List<T>();
    var data = imageData.data;

    for (var i = 0; i < data.length; i += 4) {
      var color = [data[i], data[i + 1], data[i + 2], data[i + 3]];
      pixels.add(converter(color));
    }

    return pixels;
  }

  T getPixel(int x, int y) {
    return _pixels[y * _width + x];
  }

  int get width => _width;
  int get height => _height;

  void dispose() {
    _pixels = null;
    _width = null;
    _height = null;
  }
}

class DataToColorConvertors {
  static DataToColor<String> DataToShortStringColor() {
    return (List<int> data) {
      return "${data[0]}${data[1]}${data[2]}";
    };
  }
}
