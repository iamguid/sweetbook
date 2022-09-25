import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportStateAgent extends StateAgent<SBViewportState, BaseEvent> {
  ViewportStateAgent() : super(SBViewportState.empty());

  void onAppModeChanged(SBAppMode mode) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: state.viewport,
      mode: mode,
    );

    nextState(newState);
  }

  void onViewportCahnged(SBViewport viewport) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: viewport,
      mode: state.mode,
    );

    nextState(newState);
  }

  void onStoryCaseCahnged(SBStoryCase storyCase) {
    final newState = SBViewportState(
      currentStoryCase: storyCase,
      viewport: state.viewport,
      mode: state.mode,
    );

    nextState(newState);
  }

  @override
  void onEvent(event) {
    if (event is GlobalEventModeChanged) {
      onAppModeChanged(event.payload);
    }

    if (event is GlobalEventViewportChanged) {
      onViewportCahnged(event.payload);
    }

    if (event is GlobalEventStoryCaseChanged) {
      onStoryCaseCahnged(event.payload);
    }
  }
}
