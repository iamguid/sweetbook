import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/router/create_story_app_router.dart';
import 'package:sweetbook/src/story_app_agent.dart';
import 'package:sweetbook/src/story_app_case_page.dart';
import 'package:sweetbook/src/story_app_catalog_page.dart';
import 'package:sweetbook/src/utils.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

typedef StoryAppProviderChildBuilder = Widget Function(
  BuildContext context,
  GoRouter router,
);

class StoryAppProvider extends StatefulWidget {
  final SBAppConfig appConfig;
  final SBViewport viewport;
  final SBStory story;
  final StoryAppProviderChildBuilder builder;

  const StoryAppProvider({
    super.key,
    required this.appConfig,
    required this.viewport,
    required this.story,
    required this.builder,
  });

  @override
  createState() => StoryAppProviderState();
}

class StoryAppProviderState extends State<StoryAppProvider> {
  late GoRouter router;
  late SBFolder rootFolder;
  late StoryAppAgent globalAgent;
  late HeaderStateAgent headerStateAgent;
  late CatalogStateAgent catalogStateAgent;
  late ViewportStateAgent viewportStateAgent;

  @override
  void initState() {
    rootFolder = SBFolder(
      title: 'root',
      isRoot: true,
      stories: [widget.story],
      children: [],
    );

    catalogStateAgent = CatalogStateAgent();
    viewportStateAgent = ViewportStateAgent();

    router = createStoryAppRouter(
      catalogWidgetBuilder: () => StoryAppCatalogPageWidget(
        rootFolder: rootFolder,
      ),
      storyCaseWidgetBuilder: () => StoryAppCasePageWidget(),
    );

    globalAgent = StoryAppAgent(
      router: router,
      viewportStateAgent: viewportStateAgent,
      catalogStateAgent: catalogStateAgent,
    );

    globalAgent.dispatch(GlobalEventModeChanged(SBAppMode.story));
    globalAgent.dispatch(GlobalEventViewportChanged(widget.viewport));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiAgentProvider(
      providers: [
        AgentProvider.value(value: globalAgent),
        AgentProvider.value(value: catalogStateAgent),
        AgentProvider.value(value: viewportStateAgent),
      ],
      child: widget.builder(context, router),
    );
  }
}
