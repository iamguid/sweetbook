import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/global_provider.dart';

typedef SBViewportBuilder = Widget Function(
  SBViewportState viewportState,
  Widget widget,
);

typedef SBStoryCaseBuilder = Widget Function(SBViewportState viewportState);

class Sweetbook extends StatelessWidget {
  final List<SBStory> stories;
  final SBAppConfig appConfig;
  final List<SBViewport> viewports;

  const Sweetbook(
    this.stories, {
    required this.appConfig,
    required this.viewports,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalProvider(
      appConfig: appConfig,
      viewports: viewports,
      stories: stories,
      builder: (context, router) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: appConfig.title,
        theme: appConfig.theme,
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
      ),
    );
  }
}

class SBAppConfig {
  final String title;
  final ThemeData theme;

  SBAppConfig({
    required this.title,
    required this.theme,
  });
}

abstract class SBCatalogNode {
  late SBCatalogNode? parent;

  SBCatalogNode({
    required this.parent,
  });

  String get name;

  int get deep {
    int d = 0;
    SBCatalogNode? currentNode = this;

    while (currentNode != null) {
      d += 1;
      currentNode = currentNode.parent;
    }

    return d;
  }

  String get path {
    List<String> p = [];
    SBCatalogNode? currentNode = this;

    while (currentNode != null) {
      p.add(currentNode.name);
      currentNode = currentNode.parent;
    }

    return p.join('/');
  }
}

class SBStory extends SBCatalogNode {
  final String storyPath;
  final Map<String, SBStoryCase> _cases = {};

  SBStory({
    required this.storyPath,
  }) : super(parent: null);

  @override
  String get name {
    return storyPath.split('/').last;
  }

  List<SBStoryCase> get cases {
    return _cases.values.toList();
  }

  void addCase({
    required String name,
    required SBStoryCaseBuilder builder,
  }) {
    _cases[name] = SBStoryCase(story: this, name: name, builder: builder);
  }

  SBStoryCase? getCase(String caseName) {
    return _cases[caseName];
  }
}

class SBStoryCase extends SBCatalogNode {
  final SBStory story;
  final SBStoryCaseBuilder builder;

  SBStoryCase({
    required this.story,
    required this.name,
    required this.builder,
  }) : super(parent: story);

  @override
  final String name;
}

class SBFolder extends SBCatalogNode {
  final String title;
  final List<SBFolder> children;
  final List<SBStory> stories;
  final bool isRoot;

  SBFolder({
    required this.title,
    required this.children,
    required this.stories,
    required this.isRoot,
  }) : super(parent: null);

  @override
  String get name {
    return title;
  }
}

class SBViewportState {
  final SBStoryCase? currentStoryCase;
  final SBViewport? viewport;

  const SBViewportState({
    required this.currentStoryCase,
    required this.viewport,
  });

  factory SBViewportState.empty() {
    return SBViewportState(currentStoryCase: null, viewport: null);
  }
}
