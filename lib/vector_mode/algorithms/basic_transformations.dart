import 'package:GraphicsApp/math/polygon.dart';
import 'package:GraphicsApp/math/matrix.dart';

import 'dart:math';

void transform(Polygon polygon, Matrix transform) {
  polygon.transform(transform);
}

void transformAll(List<Polygon> polygons, Matrix transform) {
  for (var polygon in polygons) {
    polygon.transform(transform);
  }
}

void identityTransform(List<Polygon> polygons) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void localXYScale(polygons, scaleX, scaleY) {
  var transform = new Matrix([
    [scaleX, 0, 0],
    [0, scaleY, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void localScale(polygons, scale) {
  var transform = new Matrix([
    [scale, 0, 0],
    [0, scale, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void reflectionX(polygons) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, -1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void reflectionY(polygons) {
  var transform = new Matrix([
    [-1, 0, 0],
    [0, 1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void reflection(polygons) {
  var transform = new Matrix([
    [-1, 0, 0],
    [0, -1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void shiftX(polygons, translate) {
  var transform = new Matrix([
    [1, 0, 0],
    [translate, 1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void shiftY(polygons, translate) {
  var transform = new Matrix([
    [1, translate, 0],
    [0, 1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void shift(polygons, shiftX, shiftY) {
  var transform = new Matrix([
    [1, shiftY, 0],
    [shiftX, 1, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void rotate(polygons, angle) {
  angle = toRadian(angle);

  var transform = new Matrix([
    [cos(angle), sin(angle), 0],
    [-sin(angle), cos(angle), 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void diagonalReflection(polygons, area) {
  var transform = new Matrix([
    [0, 1 * area, 0],
    [1 * area, 0, 0],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void translateX(polygons, value) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, 1, 0],
    [value, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void translateY(polygons, value) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, 1, 0],
    [0, value, 1]
  ]);

  transformAll(polygons, transform);
}

void translate(polygons, x, y) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, 1, 0],
    [x, y, 1]
  ]);

  transformAll(polygons, transform);
}

void projection(polygons, projectionX, projectionY) {
  var transform = new Matrix([
    [1, 0, projectionX],
    [0, 1, projectionY],
    [0, 0, 1]
  ]);

  transformAll(polygons, transform);
}

void scale(polygons, value) {
  var transform = new Matrix([
    [1, 0, 0],
    [0, 1, 0],
    [0, 0, value]
  ]);

  transformAll(polygons, transform);
}

num toRadian(num angle) {
  return angle * PI / 180;
}
