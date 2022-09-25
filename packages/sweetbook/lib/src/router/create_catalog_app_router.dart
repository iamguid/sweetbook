import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createCatalogAppRouter({
  required Widget Function() rootWidgetBuilder,
}) {
  final router = GoRouter(
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
