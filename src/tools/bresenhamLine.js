// @flow

import Point from '../math/point';
import Segment from '../math/segment';
import Bitmap from '../view/bitmap';
import Line from './line';

function getLengths(segment: Segment) {
  const dx = segment.abscissaLength;
  const dy = segment.ordinateLength;
  if (dx >= dy) return { dx, dy, swap: false };
  return { dx: dy, dy: dx, swap: true };
}

export default class BresenhamLine extends Line {
  draw(bitmap: Bitmap, segment: Segment) {
    const point = segment.startPoint.clone();
    const lengths = getLengths(segment);
    const directions = { x: segment.abscissaDirection, y: segment.ordinateDirection };
    let error = (2 * lengths.dy) - lengths.dx;

    for (let i = 0; i <= lengths.dx; i++) {
      bitmap.setPixel(point.x, point.y, this.width, this.color);
      while (error >= 0) {
        lengths.swap ? point.x += directions.x : point.y += directions.y;
        error -= 2 * lengths.dx;
      }
      lengths.swap ? point.y += directions.y : point.x += directions.x;
      error += 2 * lengths.dy;
    }
  }
}

