import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/catalog_app.dart';
import 'package:sweetbook/src/global_agent.dart';
import 'package:sweetbook/src/router/create_sweetbook_router.dart';
import 'package:sweetbook/src/utils.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

typedef GlobalProviderChildBuilder = Widget Function(
  BuildContext context,
  GoRouter router,
);

class GlobalProvider extends StatefulWidget {
  final SBAppConfig appConfig;
  final List<SBViewport> viewports;
  final List<SBStory> stories;
  final GlobalProviderChildBuilder builder;

  const GlobalProvider({
    super.key,
    required this.appConfig,
    required this.viewports,
    required this.stories,
    required this.builder,
  });

  @override
  createState() => GlobalProviderState();
}

class GlobalProviderState extends State<GlobalProvider> {
  late GoRouter router;
  late SBFolder rootFolder;
  late GlobalAgent globalAgent;
  late HeaderStateAgent headerStateAgent;
  late CatalogStateAgent catalogStateAgent;
  late ViewportStateAgent viewportStateAgent;

  @override
  void initState() {
    rootFolder = getFoldersTree(widget.stories);

    headerStateAgent = HeaderStateAgent();
    catalogStateAgent = CatalogStateAgent();
    viewportStateAgent = ViewportStateAgent();

    router = createSweetbookRouter(
      rootWidgetBuilder: () => CatalogAppWidget(
        rootFolder: rootFolder,
        appConfig: widget.appConfig,
        viewports: widget.viewports,
      ),
      catalogStateAgent: catalogStateAgent,
      viewportStateAgent: viewportStateAgent,
    );

    globalAgent = GlobalAgent(
      router: router,
      headerStateAgent: headerStateAgent,
      viewportStateAgent: viewportStateAgent,
      catalogStateAgent: catalogStateAgent,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiAgentProvider(
      providers: [
        AgentProvider.value(value: globalAgent),
        AgentProvider.value(value: headerStateAgent),
        AgentProvider.value(value: catalogStateAgent),
        AgentProvider.value(value: viewportStateAgent),
      ],
      child: widget.builder(context, router),
    );
  }
}
