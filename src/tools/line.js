// @flow

class Line {
  color: string;
  width: number;

  constructor(color: string, width: number) {
    this.color = color;
    this.width = width;
  }

  set setColor(value: string) {
    this.color = value;
  }

  set setWidth(value: number) {
    return this.width;
  }
}

export default Line;

