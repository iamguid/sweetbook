import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_empty.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportWidget extends StatelessWidget {
  const ViewportWidget({super.key});

  Widget buildViewport(BuildContext context, SBViewportState state) {
    if (state.currentStoryCase == null || state.viewport == null) {
      return ViewportEmptyWidget();
    }

    final storyCaseWidget = state.currentStoryCase!.builder(state);
    final viewportWidget = state.viewport!.build(state, storyCaseWidget);

    return viewportWidget;
  }

  @override
  Widget build(BuildContext context) {
    return StateAgentBuilder<ViewportStateAgent, SBViewportState>(
      builder: buildViewport,
    );
  }
}
