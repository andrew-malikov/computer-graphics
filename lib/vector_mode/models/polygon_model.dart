import 'package:GraphicsApp/vector_mode/arch/i_observable.dart';
import 'package:GraphicsApp/vector_mode/arch/i_observer.dart';
import 'package:GraphicsApp/math/polygon.dart';

class PolygonModel implements IObservable {
  List<IObserver> _observers;
  Polygon _polygon;

  PolygonModel() {
    _observers = new List<IObserver>();
  }

  set value(Polygon polygon) {
    _polygon = polygon;
    notifyObservers();
  }

  Polygon get value => _polygon;

  @override
  void notifyObservers() {
    _observers.forEach((o) {
      o.Update();
    });
  }

  @override
  void subscribeObserver(IObserver observer) {
    _observers.add(observer);
  }

  @override
  void unsubscribeObserver(IObserver observer) {
    _observers.remove(observer);
  }
}
