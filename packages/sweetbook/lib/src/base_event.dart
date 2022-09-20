abstract class BaseEvent {}

abstract class PayloadedEvent<T> extends BaseEvent {
  final T payload;

  PayloadedEvent(this.payload);
}
