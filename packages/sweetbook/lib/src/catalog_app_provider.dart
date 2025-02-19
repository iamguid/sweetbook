import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/catalog_app.dart';
import 'package:sweetbook/src/catalog_app_agent.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/router/create_catalog_app_router.dart';
import 'package:sweetbook/src/utils.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

typedef CatalogAppProviderChildBuilder = Widget Function(
  BuildContext context,
  GoRouter router,
);

class CatalogAppProvider extends StatefulWidget {
  final SBAppConfig appConfig;
  final List<SBViewport> viewports;
  final List<SBStory> stories;
  final CatalogAppProviderChildBuilder builder;

  CatalogAppProvider({
    super.key,
    required this.appConfig,
    required this.viewports,
    required this.stories,
    required this.builder,
  }) : assert(viewports.isNotEmpty, 'You should provide minimum one viewport');

  @override
  createState() => CatalogAppProviderState();
}

class CatalogAppProviderState extends State<CatalogAppProvider> {
  late GoRouter router;
  late SBFolder rootFolder;
  late CatalogAppAgent globalAgent;
  late HeaderStateAgent headerStateAgent;
  late CatalogStateAgent catalogStateAgent;
  late ViewportStateAgent viewportStateAgent;

  @override
  void initState() {
    rootFolder = getFoldersTree(widget.stories);

    headerStateAgent = HeaderStateAgent();
    catalogStateAgent = CatalogStateAgent();
    viewportStateAgent = ViewportStateAgent();

    router = createCatalogAppRouter(
      rootWidgetBuilder: () => CatalogAppWidget(
        rootFolder: rootFolder,
        appConfig: widget.appConfig,
        viewports: widget.viewports,
      ),
    );

    globalAgent = CatalogAppAgent(
      router: router,
      headerStateAgent: headerStateAgent,
      viewportStateAgent: viewportStateAgent,
      catalogStateAgent: catalogStateAgent,
    );

    globalAgent.emit('global', ViewportChanged(widget.viewports.first));
    globalAgent.emit('global', ModeChanged(SBAppMode.catalog));

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
