import 'package:agent_flutter/agent_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';

class StoryAppAgent extends Agent {
  final GoRouter router;
  final ViewportStateAgent viewportStateAgent;
  final CatalogStateAgent catalogStateAgent;

  StoryAppAgent({
    required this.router,
    required this.viewportStateAgent,
    required this.catalogStateAgent,
  }) : super() {
    on<StoryCaseChanged>('global', (topic, event) {
      router.pushNamed('/case');
    });

    on<BackToCatalog>('global', (topic, event) {
      router.pop();
    });

    on<StoryCaseTapEvent>('catalog', (topic, event) {
      Future.microtask(() => emit('global', StoryCaseChanged(event.payload)));
    });

    connect(viewportStateAgent);
    connect(catalogStateAgent);
  }
}
