// @flow

import Point from './point';

export default class PointBuilder {
  static defaultPoint() {
    return new Point(0, 0);
  }
}
