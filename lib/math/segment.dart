import 'dart:math';

import 'Package:GraphicsApp/math/point.dart';


class Segment {
  Point2D _start;
  Point2D _end;

  Segment(this._start, this._end) {}

  Point2D get start => _start;

  void set start(Point2D point) {
    this._start = point;
  }

  Point2D get end => _end;

  void set end(Point2D point) {
    this._end = point;
  }

  num get abscissaLength {
    return (end.x - start.x).abs();
  }

  num get abscissaDirection {
    return (end.x - start.x).sign;
  }

  num get ordinateLength {
    return (end.y - start.y).abs();
  }

  num get ordinateDirection {
    return (end.y - start.y).sign;
  }

  num get longProjectionOnAxis {
    return abscissaLength >= ordinateLength ? abscissaLength : ordinateLength;
  }

  num get length {
    return sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
  }

  bool isPoint() {
    return end == start;
  }

  String toString() {
    return '${start}/${end}';
  }
}
