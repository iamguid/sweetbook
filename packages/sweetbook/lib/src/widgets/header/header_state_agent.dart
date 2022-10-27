import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/header/header_state.dart';

class HeaderStateAgent extends StateAgent<HeaderState, BaseEvent> {
  HeaderStateAgent() : super(HeaderState.empty()) {
    on<GlobalEventViewportChanged>((event) {
      final newState = HeaderState(
        selectedViewport: event.payload,
      );

      nextState(newState);
    });
  }
}
