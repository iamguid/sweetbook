import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/decorator.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/catalog_app_provider.dart';
import 'package:sweetbook/src/decorators/just_decorator.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/story_app_provider.dart';

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

  static story(
    SBStory story, {
    required appConfig,
    required viewport,
  }) {
    return StoryAppProvider(
      appConfig: appConfig,
      viewport: viewport,
      story: story,
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

  @override
  Widget build(BuildContext context) {
    return CatalogAppProvider(
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

  void addCases(List<SBStoryCase> cases) {
    for (var storyCase in cases) {
      _cases[storyCase.name] = storyCase;
    }
  }

  void addCase({
    required String name,
    required SBStoryCaseBuilder builder,
    SBDecorator decorator = const JustDecorator(),
  }) {
    _cases[name] = SBStoryCase(
      story: this,
      name: name,
      builder: builder,
      decorator: decorator,
    );
  }

  SBStoryCase? getCase(String caseName) {
    return _cases[caseName];
  }
}

class SBStoryCase extends SBCatalogNode {
  final SBStory story;
  final SBStoryCaseBuilder builder;
  final SBDecorator decorator;

  SBStoryCase({
    required this.story,
    required this.name,
    required this.builder,
    required this.decorator,
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
  final SBAppMode? mode;

  const SBViewportState({
    required this.currentStoryCase,
    required this.viewport,
    required this.mode,
  });

  factory SBViewportState.empty() {
    return SBViewportState(
      currentStoryCase: null,
      viewport: null,
      mode: null,
    );
  }
}
