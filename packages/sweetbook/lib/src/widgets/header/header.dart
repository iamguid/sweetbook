import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/header/header_state.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

class HeaderWidget extends StatelessWidget {
  final SBAppConfig appConfig;
  final List<SBViewport> viewports;

  const HeaderWidget({
    super.key,
    required this.appConfig,
    required this.viewports,
  });

  List<DropdownMenuItem<SBViewport>> buildViewportsDropdownMenuItems() {
    return viewports
        .map((v) => DropdownMenuItem(child: Text(v.title), value: v))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final headerStateAgent = AgentProvider.of<HeaderStateAgent>(context);

    return StateAgentBuilder<HeaderStateAgent, HeaderState>(
      builder: (context, state) => Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                appConfig.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              DropdownButton<SBViewport>(
                items: buildViewportsDropdownMenuItems(),
                value: state.selectedViewport,
                onChanged: (value) => headerStateAgent
                    .dispatch(GlobalEventViewportChanged(value!)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
