import 'Package:GraphicsApp/interfaces/i_observer.dart';

abstract class IObservable {
  void subscribeObserver(IObserver observer);
  void unsubscribeObserver(IObserver observer);
  void NotifyObservers(Object object);
}