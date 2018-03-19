// @flow

import LineComponent from './lineComponent';

import Bitmap from '../view/bitmap';
import Point from '../math/point';

export default class LineComponentManager {
  bitmap: Bitmap;
  components: Array<LineComponent>;
  clickHandler: Function;

  constructor(bitmap: Bitmap) {
    this.components = [];
    this.setBitmap = bitmap;
  }

  addComponent(value: LineComponent) {
    this.components.push(value);
  }

  removeComponent(value: LineComponent) {
    this.components = this.components.filter((component) => {
      if (component === value) return false;
      return true;
    });
  }

  addClickHandler() {
    this.clickHandler = this.click.bind(this);
    this.bitmap.render().addEventListener('click', this.clickHandler);
  }

  removeClickHandler() {
    this.bitmap.render().removeEventListener('click', this.clickHandler);
  }

  click(event: Event) {
    const rect = this.bitmap.render().getBoundingClientRect();
    const point = new Point(event.clientX - rect.left, event.clientY - rect.top);
    this.components.forEach((component) => {
      component.sendAction(point, this.bitmap);
    });
  }

  set setBitmap(value: Bitmap) {
    if (typeof this.bitmap === typeof Bitmap) {
      this.removeClickHandler();
    }
    this.bitmap = value;
    this.addClickHandler();
  }
}
