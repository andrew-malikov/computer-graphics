import 'dart:html';

import 'package:TestCG/view/bitmap.dart';
import 'package:TestCG/app.dart';

void main() {
  // App app = new App(new Bitmap(480, 640), "It's work... again!");
  // app.setClickHandler();
  // document.body.append(app.bitmap.canvas);

  initializeApp();
}

class App {
  Bitmap bitmap;
  String handleMessage;

  App(this.bitmap, this.handleMessage) {}

  void setClickHandler() {
    bitmap.canvas.addEventListener('click', click);
  }

  void click(Event event) {
    print(handleMessage);
    print(event.type);
    print(event.runtimeType);
    print(event.scoped);
    print("${event.timeStamp}");
    MouseEvent mouseEvent = event as MouseEvent;
    print(mouseEvent.client.x);
    print(mouseEvent.client.y);
  }
}
