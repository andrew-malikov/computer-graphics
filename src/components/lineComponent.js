// @flow

import LineStates from './lineStates';
import Bitmap from '../view/bitmap';
import Line from '../tools/line';
import PointBuilder from '../math/pointBuilder';
import Point from '../math/point';
import Segment from '../math/segment';

export default class LineComponent {
  state: string;
  startPoint: Point;
  lineTool: Line;

  constructor(state: string, lineTool: Line) {
    this.state = state;
    this.startPoint = PointBuilder.defaultPoint();
    this.lineTool = lineTool;
  }

  sendAction(point: Point, bitmap: Bitmap) {
    if (this.state === LineStates.setStartPoint) {
      this.setStartPoint = point;
      this.state = LineStates.setEndPoint;
    } else if (this.state === LineStates.setEndPoint) {
      this.lineTool.draw(bitmap, new Segment(this.startPoint, point));
      this.startPoint = PointBuilder.defaultPoint();
      this.state = LineStates.setStartPoint;
    }
  }

  set setLineTool(value: Line) {
    this.lineTool = value;
  }

  disable() {
    this.state = LineStates.disable;
  }

  enable() {
    this.state = LineStates.setStartPoint;
  }

  set setStartPoint(value: Point) {
    this.startPoint = value;
  }

  get getState(): string {
    return this.state;
  }
}
