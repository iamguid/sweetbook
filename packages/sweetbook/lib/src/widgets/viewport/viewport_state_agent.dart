import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportStateAgent extends StateAgent<SBViewportState> {
  ViewportStateAgent() : super(SBViewportState.empty()) {
    on<ModeChanged>('global', onAppModeChanged);
    on<ViewportChanged>('global', onViewportCahnged);
    on<StoryCaseChanged>('global', onStoryCaseCahnged);
  }

  void onAppModeChanged(String topic, ModeChanged event) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: state.viewport,
      mode: event.payload,
    );

    nextState(newState);
  }

  void onViewportCahnged(String topic, ViewportChanged event) {
    final newState = SBViewportState(
      currentStoryCase: state.currentStoryCase,
      viewport: event.payload,
      mode: state.mode,
    );

    nextState(newState);
  }

  void onStoryCaseCahnged(String topic, StoryCaseChanged event) {
    final newState = SBViewportState(
      currentStoryCase: event.payload,
      viewport: state.viewport,
      mode: state.mode,
    );

    nextState(newState);
  }
}
