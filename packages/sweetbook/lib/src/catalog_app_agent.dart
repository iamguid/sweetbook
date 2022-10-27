import 'package:agent_flutter/agent_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';

class CatalogAppAgent extends Agent<BaseEvent> {
  final GoRouter router;
  final HeaderStateAgent headerStateAgent;
  final ViewportStateAgent viewportStateAgent;
  final CatalogStateAgent catalogStateAgent;

  CatalogAppAgent({
    required this.router,
    required this.headerStateAgent,
    required this.viewportStateAgent,
    required this.catalogStateAgent,
  }) : super() {
    on<CatalogStoryCasePressEvent>((event) {
      dispatch(GlobalEventStoryCaseChanged(event.payload));
    });

    connect(headerStateAgent);
    connect(viewportStateAgent);
    connect(catalogStateAgent);
  }
}
