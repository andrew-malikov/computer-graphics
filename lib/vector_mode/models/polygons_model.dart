import 'package:GraphicsApp/vector_mode/arch/i_observable.dart';
import 'package:GraphicsApp/vector_mode/arch/i_observer.dart';
import 'package:GraphicsApp/math/polygon.dart';

class PolygonsModel implements IObservable {
  List<IObserver> _observers;
  List<Polygon> _polygons;

  PolygonsModel() {
    _observers = new List<IObserver>();
    _polygons = new List<Polygon>();
  }

  void add(Polygon polygon) {
    _polygons.add(polygon);
    notifyObservers();
  }

  void addAll(Iterable<Polygon> polygons) {
    _polygons.addAll(polygons);
    notifyObservers();
  }

  void remove(Polygon polygon) {
    _polygons.remove(polygon);
    notifyObservers();
  }

  void removeAll() {
    _polygons.clear();
    notifyObservers();
  }

  List<Polygon> get values => _polygons;

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
