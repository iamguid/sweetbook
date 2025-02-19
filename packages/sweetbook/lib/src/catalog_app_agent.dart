import 'package:agent_flutter/agent_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/header/header_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';

class CatalogAppAgent extends Agent {
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
    on<StoryCaseTapEvent>('catalog', (topic, event) {
      // Because you can't emit two events in one time
      Future.microtask(() {
        emit('global', StoryCaseChanged(event.payload));
      });
    });

    // Just listen to global events
    on<AgentBaseEvent>('global', (topic, event) {});

    connect(headerStateAgent);
    connect(viewportStateAgent);
    connect(catalogStateAgent);
  }
}
