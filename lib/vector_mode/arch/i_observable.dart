import 'Package:GraphicsApp/vector_mode/arch/i_observer.dart';

abstract class IObservable {
  void subscribeObserver(IObserver observer);
  void unsubscribeObserver(IObserver observer);
  void notifyObservers();
}