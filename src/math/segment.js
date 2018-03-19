// @flow

import Point from './point';

export default class Segment {
  startPoint: Point;
  endPoint: Point;

  constructor(startPoint: Point, endPoint: Point) {
    this.startPoint = startPoint;
    this.endPoint = endPoint;
  }

  set setStartPoint(value: Point) {
    this.startPoint = value;
  }

  set setEndPoint(value: Point) {
    this.endPoint = value;
  }

  get abscissaLength(): number {
    return Math.abs(this.endPoint.x - this.startPoint.x);
  }

  get abscissaDirection(): number {
    return Math.sign(this.endPoint.x - this.startPoint.x);
  }

  get ordinateLength(): number {
    return Math.abs(this.endPoint.y - this.startPoint.y);
  }

  get ordinateDirection(): number {
    return Math.sign(this.endPoint.y - this.startPoint.y);
  }

  get longProjectionOnAxis(): number {
    return this.abscissaLength >= this.ordinateLength
      ? this.abscissaLength
      : this.ordinateLength;
  }
}
