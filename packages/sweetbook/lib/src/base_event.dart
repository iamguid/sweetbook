import 'package:agent_flutter/agent_flutter.dart';

abstract class BaseEvent extends AgentBaseEvent {}

abstract class PayloadEvent<T> extends BaseEvent {
  final T payload;

  PayloadEvent(this.payload);
}
