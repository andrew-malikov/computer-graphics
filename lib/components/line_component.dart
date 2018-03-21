import '../view/bitmap.dart';
import '../view/layer.dart';
import '../tools/line.dart';
import '../math/point.dart';
import '../math/segment.dart';
import 'component.dart';

import 'dart:html';

enum State { SetStartPoint, SetEndPoint }

class LineComponent extends Component {
  State _state;
  Point2D _point;
  Line _tool;

  LineComponent(Line tool) : super(null) {
    _state = State.SetStartPoint;
    _point = Point2DBuilder.defaultPoint();
    _tool = tool;
  }

  void addEvents() {
    if (!hasLayer()) return;
    layer.body.canvas.addEventListener('click', click);
    layer.body.canvas.addEventListener('mousemove', move);
  }

  void removeEvents() {
    if (!hasLayer()) return;
    layer.body.canvas.removeEventListener('click', click);
    layer.body.canvas.removeEventListener('mousemove', move);
  }

  void click(Event event) {
    window.requestAnimationFrame((time) {
      MouseEvent mouseEvent = event as MouseEvent;
      if (state == State.SetStartPoint) {
        _point = _computePoint(mouseEvent, layer.body);
        _state = State.SetEndPoint;
      } else {
        Point2D endPoint = _computePoint(mouseEvent, layer.body);
        tool.draw(layer.body, new Segment(point, endPoint));
        layer.preview.clear();
        _state = State.SetStartPoint;
      }
    });
  }

  void move(Event event) {
    window.requestAnimationFrame((time) {
      if (_state != State.SetEndPoint) return;
      MouseEvent mouseEvent = event as MouseEvent;
      layer.preview.clear();
      Point2D endPoint = _computePoint(mouseEvent, layer.preview);
      tool.draw(layer.preview, new Segment(_point, endPoint));
    });
  }

  void unsetLayer() {
    removeEvents();
    layer = null;
  }

  Point2D _computePoint(MouseEvent event, Bitmap bitmap) {
    Rectangle<num> border = bitmap.canvas.getBoundingClientRect();
    return new Point2D(
        event.client.x - border.left, event.client.y - border.top);
  }

  bool hasLayer() => layer != null;

  State get state => _state;

  Point2D get point => _point;

  Line get tool => _tool;
  void set(Line tool) => _tool = tool;
}
