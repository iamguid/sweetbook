import 'package:agent_flutter/agent_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';

class StoryAppAgent extends Agent<BaseEvent> {
  final GoRouter router;
  final ViewportStateAgent viewportStateAgent;
  final CatalogStateAgent catalogStateAgent;

  StoryAppAgent({
    required this.router,
    required this.viewportStateAgent,
    required this.catalogStateAgent,
  }) : super() {
    connect(viewportStateAgent);
    connect(catalogStateAgent);

    on<CatalogStoryCasePressEvent>((event) {
      dispatch(GlobalEventStoryCaseChanged(event.payload));
      router.pushNamed('/case');
    });

    on<GlobalEventBackToCatalog>((event) {
      router.pop();
    });
  }
}
