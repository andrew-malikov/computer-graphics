// @flow

import Point from './math/point';
import Segment from './math/segment';
import Bitmap from './view/bitmap';
import CDALine from './tools/cdaLine';
import BresenhamLine from './tools/bresenhamLine';
import LineComponent from './components/lineComponent';
import LineComponentManager from './components/lineComponentManager';
import LineStates from './components/lineStates';

const bitmap = new Bitmap(640, 420);
const cdaLine = new CDALine('#71b2b2', 1);
const bresenhamLine = new BresenhamLine('#f2b271', 1);
const lineComponent = new LineComponent(LineStates.setStartPoint, bresenhamLine);
const lineComponentManager = new LineComponentManager(bitmap);

document.body.appendChild(bitmap.render());

lineComponentManager.addComponent(lineComponent);
