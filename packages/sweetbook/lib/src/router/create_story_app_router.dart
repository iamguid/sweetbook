import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createStoryAppRouter({
  required Widget Function() catalogWidgetBuilder,
  required Widget Function() storyCaseWidgetBuilder,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        name: '/',
        path: '/',
        builder: (context, state) {
          return catalogWidgetBuilder();
        },
      ),
      GoRoute(
        name: '/case',
        path: '/case',
        builder: (context, state) {
          return storyCaseWidgetBuilder();
        },
      ),
    ],
  );

  return router;
}
