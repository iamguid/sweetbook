import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_empty.dart';
import 'package:sweetbook/sweetbook.dart';

class ViewportWidget extends StatelessWidget {
  const ViewportWidget({super.key});

  Widget buildViewport(BuildContext context, SBViewportState state) {
    if (state.currentStoryCase == null || state.viewport == null) {
      return ViewportEmptyWidget();
    }

    final storyCase = state.currentStoryCase!;
    final storyCaseWidget = storyCase.builder(state);
    final decoratorWidget = storyCase.decorator.build(state, storyCaseWidget);
    final viewportWidget = state.viewport!.build(state, decoratorWidget);

    return viewportWidget;
  }

  @override
  Widget build(BuildContext context) {
    final viewportStateAgent = AgentProvider.of<ViewportStateAgent>(context);

    return StateAgentBuilder<ViewportStateAgent, SBViewportState>(
      builder: (context, state) => Stack(children: [
        Align(
          alignment: Alignment.center,
          child: buildViewport(context, state),
        ),
        state.mode == SBAppMode.story
            ? Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  onPressed: () =>
                      viewportStateAgent.dispatch(GlobalEventBackToCatalog()),
                  child: Icon(Icons.arrow_back_rounded, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      backgroundColor: Theme.of(context).cardColor),
                ),
              )
            : Container(),
      ]),
    );
  }
}
