// @flow

export default class Bitmap {
  canvas: HTMLCanvasElement;
  context: CanvasRenderingContext2D;

  constructor(widht: number, height: number) {
    this.canvas = document.createElement('canvas');
    this.context = this.canvas.getContext('2d');
    this.canvas.width = widht;
    this.canvas.height = height;
  }

  setPixel(x: number, y: number, size: number, color: string) {
    this.context.fillStyle = color;
    this.context.fillRect(x, y, size, size);
  }

  render(): HTMLCanvasElement {
    return this.canvas;
  }
}
