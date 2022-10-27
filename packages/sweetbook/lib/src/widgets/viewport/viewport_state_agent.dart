import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportStateAgent extends StateAgent<SBViewportState, BaseEvent> {
  ViewportStateAgent() : super(SBViewportState.empty()) {
    on<GlobalEventModeChanged>(onAppModeChanged);
    on<GlobalEventViewportChanged>(onViewportCahnged);
    on<GlobalEventStoryCaseChanged>(onStoryCaseCahnged);
  }

  void onAppModeChanged(GlobalEventModeChanged event) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: state.viewport,
      mode: event.payload,
    );

    nextState(newState);
  }

  void onViewportCahnged(GlobalEventViewportChanged event) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: event.payload,
      mode: state.mode,
    );

    nextState(newState);
  }

  void onStoryCaseCahnged(GlobalEventStoryCaseChanged event) {
    final newState = SBViewportState(
      currentStoryCase: event.payload,
      viewport: state.viewport,
      mode: state.mode,
    );

    nextState(newState);
  }
}
