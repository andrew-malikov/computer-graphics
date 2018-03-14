// @flow

import Line from './line';
import Segment from '../math/segment';
import Bitmap from '../view/bitmap';

export default class CDALine extends Line {
  draw(bitmap: Bitmap, segment: Segment) {
    const length = segment.longProjectionOnAxis;
    const increments = {
      x: segment.abscissaLength * segment.abscissaDirection / length,
      y: segment.ordinateLength * segment.ordinateDirection / length,
    };
    const point = {
      x: segment.startPoint.x + increments.x,
      y: segment.startPoint.y + increments.y,
    };

    for (let i = 0; i < length; i++) {
      bitmap.setPixel(Math.ceil(point.x), Math.ceil(point.y), this.width, this.color);
      point.x += increments.x;
      point.y += increments.y;
    }
  }
}
