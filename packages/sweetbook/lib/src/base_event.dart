import 'package:agent_flutter/agent_flutter.dart';

abstract class BaseEvent extends AgentBaseEvent {}

abstract class PayloadedEvent<T> extends BaseEvent {
  final T payload;

  PayloadedEvent(this.payload);
}
