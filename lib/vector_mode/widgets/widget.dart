import 'dart:html';

import 'package:GraphicsApp/vector_mode/widgets/i_viewable.dart';

typedef void Action(Event event);

class WidgetEvents {
  HtmlElement element;
  Map<String, Action> events;

  WidgetEvents(this.element) {
    events = new Map();
  }

  void addEvents() {
    for (String key in events.keys) element.addEventListener(key, events[key]);
  }

  void removeEvents() {
    for (String key in events.keys)
      element.removeEventListener(key, events[key]);
  }
}

abstract class Widget implements IViewable {
  Map<String, WidgetEvents> actions;

  Widget() {
    actions = new Map();
  }

  void enable() {
    for (var events in actions.values) {
      events.addEvents();
    }
  }

  void disable() {
    for (var events in actions.values) {
      events.removeEvents();
    }
  }
}
