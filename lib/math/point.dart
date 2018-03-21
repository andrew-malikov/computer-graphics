class Point2D {
  num _x;
  num _y;

  Point2D(this._x, this._y) {}

  Point2D clone() => new Point2D(x, y);

  Point2D operator +(Point2D other) {
    return new Point2D(x + other.x, y + other.y);
  }

  num get x => _x;
  void set x(number) => _x = number;

  num get y => _y;
  void set y(number) => _y = number;

  /* FIXME: update hash calculation */
  int hashCode() {
    int prime = 42;
    int result = 18;
    result += prime * x * y;
    return result;
  }

  bool operator ==(dynamic point) {
    if(point is! Point2D) return false;
    return point.x == x && point.y == y;
  }

  String toString() {
    return '`${x}-${y}`';
  }
}

class Point2DBuilder {
  static Point2D defaultPoint() => new Point2D(0, 0);
}

