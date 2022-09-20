import 'package:agent_flutter/agent_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';
import 'package:sweetbook/sweetbook.dart';

class GlobalAgent extends Agent<BaseEvent> {
  final GoRouter router;
  final HeaderStateAgent headerStateAgent;
  final ViewportStateAgent viewportStateAgent;
  final CatalogStateAgent catalogStateAgent;

  GlobalAgent({
    required this.router,
    required this.headerStateAgent,
    required this.viewportStateAgent,
    required this.catalogStateAgent,
  }) : super() {
    router.addListener(routerListener);

    headerStateAgent.connect(this);
    connect(headerStateAgent);

    viewportStateAgent.connect(this);
    connect(viewportStateAgent);

    catalogStateAgent.connect(this);
    connect(catalogStateAgent);
  }

  void routerListener() {}

  @override
  void onEvent(event) {
    if (event is CatalogStoryCasePressEvent) {
      dispatch(GlobalEventStoryCaseChanged(event.payload));
    }
  }
}
