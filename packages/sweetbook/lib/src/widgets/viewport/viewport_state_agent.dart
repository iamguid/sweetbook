import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportStateAgent extends StateAgent<SBViewportState, BaseEvent> {
  ViewportStateAgent() : super(SBViewportState.empty());

  @override
  void onEvent(event) {
    if (event is GlobalEventViewportChanged) {
      final newState = SBViewportState(
        currentStoryCase: state.currentStoryCase,
        viewport: event.payload,
      );

      nextState(newState);
    }

    if (event is GlobalEventStoryCaseChanged) {
      final newState = SBViewportState(
        currentStoryCase: event.payload,
        viewport: state.viewport,
      );

      nextState(newState);
    }
  }
}
