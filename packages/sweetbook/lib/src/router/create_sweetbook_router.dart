import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/viewport/viewport_state_agent.dart';

GoRouter createSweetbookRouter({
  required Widget Function() rootWidgetBuilder,
  required CatalogStateAgent catalogStateAgent,
  required ViewportStateAgent viewportStateAgent,
}) {
  final router = GoRouter(
    redirect: (routerState) {
      final theme = routerState.queryParams['theme'];
      final path = routerState.queryParams['path'];
    },
    routes: [
      GoRoute(
        name: '/',
        path: '/',
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            child: rootWidgetBuilder(),
          );
        },
      ),
    ],
  );

  return router;
}
