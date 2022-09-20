import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/header/header_state.dart';

class HeaderStateAgent extends StateAgent<HeaderState, BaseEvent> {
  HeaderStateAgent() : super(HeaderState.empty());

  @override
  void onEvent(event) {
    if (event is GlobalEventViewportChanged) {
      final newState = HeaderState(selectedViewport: event.payload);
      nextState(newState);
    }
  }
}
