import 'Package:GraphicsApp/interfaces/i_observer.dart';

abstract class IObserveable {
  void addObserver(IObserver observer);
  void removeObserver(IObserver observer);
  void NotifyObservers();
}