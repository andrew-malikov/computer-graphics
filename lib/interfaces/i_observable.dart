import 'Package:GraphicsApp/interfaces/i_observer.dart';

abstract class IObserveable {
  void subscribeObserver(IObserver observer);
  void unsubscribeObserver(IObserver observer);
  void NotifyObservers();
}