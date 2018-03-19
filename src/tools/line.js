// @flow

import Bitmap from '../view/bitmap';
import Segment from '../math/segment';

class Line {
  color: string;
  width: number;

  constructor(color: string, width: number) {
    this.color = color;
    this.width = width;
  }

  draw(bitmap: Bitmap, segment: Segment) {
    throw new TypeError('Not Implemented');
  }

  set setColor(value: string) {
    this.color = value;
  }

  set setWidth(value: number) {
    return this.width;
  }
}

export default Line;
