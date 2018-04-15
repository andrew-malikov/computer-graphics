let body = document.createElement("body");

document.body = body;

let canvas = document.createElement("canvas");
let context = canvas.getContext("2d");

canvas.width = 640;
canvas.height = 480;

body.append(canvas);

function clear() {
  context.clearRect(0, 0, canvas.width, canvas.height);
}

function colorize() {
  console.log("Colorize: Start");
  let start = new Date();

  for (let i = 0; i <= canvas.width; i += 10) {
    for (let j = 0; j <= canvas.height; j += 10) {
      context.fillStyle = getRandomColor();
      context.fillRect(i, j, 9, 9);
    }
  }

  let end = new Date();

  console.log(
    `Colorize: ElapsedTime[ms] -> ${end.getTime() - start.getTime()}`
  );
  console.log("Colorize: End");
}

function getRandomColor() {
  return `rgb(${intRandom(0, 255)},${intRandom(0, 255)},${intRandom(0, 255)}`;
}

function intRandom(min, max) {
  return Math.round(random(min, max));
}

function random(min, max) {
  return Math.random() * (max - min) + min;
}

function testFill() {
  let start = new Date();

  for (let i = 0; i <= canvas.width; i++) {
    for (let j = 0; j <= canvas.height; j++) {
      context.fillStyle = "#000";
      context.fillRect(i, j, 1, 1);
    }
  }

  let end = new Date();

  console.log(end.getTime() - start.getTime());
}

function testGetPixelsData01() {
  let start = new Date();

  for (let i = 0; i <= canvas.width; i++) {
    for (let j = 0; j <= canvas.height; j++) {
      context.getImageData(i, j, 1, 1).data;
    }
  }

  let end = new Date();

  console.log(end.getTime() - start.getTime());
}

function getPixelsData(convertFunction) {
  console.log("GetPixelsData-02: Start");
  let start = new Date();

  let imageData = context.getImageData(0, 0, canvas.width, canvas.height);
  let pixelRows = [];

  for (let i = 0; i < imageData.height; i++) {
    let pixelRow = [];

    for (let j = 0; j < imageData.width; j++) {
      pixelRow.push(convertFunction(getColor02(imageData, j, i)));
    }

    pixelRows.push(pixelRow);
  }

  let end = new Date();

  console.log(
    `GetPixelsData-02: ElapsedTime[ms] -> ${end.getTime() - start.getTime()}`
  );
  console.log("GetPixelsData-02: End");

  return pixelRows;
}

function getColor01(data) {
  return `${data[0]}${data[1]}${data[2]}`;
}

function getColor02(imageData, x, y) {
  let data = imageData.data;
  let index = y * imageData.width * 4 + x * 4;
  return [data[index], data[index + 1], data[index + 2], data[index + 3]];
}

function colorToString(color) {
  return `rgb(${color[0]},${color[1]},${color[2]})`;
}

function fill(canvas, context, x, y, color) {
  console.log("Fill: Start");
  let start = new Date();

  x = Math.round(x);
  y = Math.round(y);

  let pixels = getPixelsData(getColor01);

  let baseColor = pixels[y][x];
  let points = new Array();

  points.push({ x: x, y: y });
  pixels[y][x] = 1;

  while (points.length > 0) {
    let { x, y } = points.pop();

    context.fillStyle = color;
    context.fillRect(x, y, 1, 1);

    let newX = x;
    let newY = y - 1;
    if (newY >= 0) {
      if (pixels[newY][newX] == baseColor) {
        points.push({ x: newX, y: newY });
        pixels[newY][newX] = 1;
      }
    }

    newX = x + 1;
    newY = y;
    if (newX < canvas.width) {
      if (pixels[newY][newX] == baseColor) {
        points.push({ x: newX, y: newY });
        pixels[newY][newX] = 1;
      }
    }

    newX = x;
    newY = y + 1;
    if (newY < canvas.height) {
      if (pixels[newY][newX] == baseColor) {
        points.push({ x: newX, y: newY });
        pixels[newY][newX] = 1;
      }
    }

    newX = x - 1;
    newY = y;
    if (newX >= 0) {
      if (pixels[newY][newX] == baseColor) {
        points.push({ x: newX, y: newY });
        pixels[newY][newX] = 1;
      }
    }
  }

  let end = new Date();

  console.log(`Fill: ElapsedTime[ms] -> ${end.getTime() - start.getTime()}`);
  console.log("Fill: End");
}

// testFill();

// clear();

// testGetPixelsData01();

colorize();

// testGetPixelsData02();
