import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/header/header_state.dart';

class HeaderStateAgent extends StateAgent<HeaderState> {
  HeaderStateAgent() : super(HeaderState.empty()) {
    on<ViewportChanged>('global', (topic, event) {
      final newState = HeaderState(
        selectedViewport: event.payload,
      );

      nextState(newState);
    });
  }
}
