import 'package:flutter/material.dart';
import 'package:sweetbook/src/viewports.dart';

/// The main class that makes app for explore collection of widgets
class Sweetbook extends StatelessWidget {
  final SBAppConfig appConfig;
  final SBViewportBuilder builder;

  const Sweetbook(
    List<SBStory> stories, {
    required this.appConfig,
    required this.builder,
  });

  /// That static function needs for creating isolated widget container
  ///
  /// This function creates [SBStoryCaseContainer] widget in
  /// [MaterialApp] container
  static story(
    SBStory story, {
    required SBAppConfig appConfig,
    required SBViewportBuilder builder,
  }) {
    return MaterialApp(
        title: appConfig.title,
        theme: appConfig.theme,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (context) => ListView(
                    children: story.cases
                        .map((c) => TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/${c.name}'),
                            child: Text(c.name)))
                        .toList()),
              );
            default:
              final storyCaseName = settings.name!.split('/')[1];

              final sbContext = SBContext(
                stories: [story],
                currentStoryCase: story.getCase(storyCaseName),
              );

              return MaterialPageRoute(
                builder: (context) => builder(sbContext),
              );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class SBContext {
  final List<SBStory> stories;
  late SBStoryCase? currentStoryCase;

  SBContext({
    required this.stories,
    this.currentStoryCase,
  });
}

class SBAppConfig {
  final String title;
  final ThemeData theme;

  SBAppConfig({
    required this.title,
    required this.theme,
  });
}

class SBStory {
  final String path;
  final Map<String, SBStoryCase> _cases = {};

  SBStory({required this.path});

  List<SBStoryCase> get cases {
    return _cases.values.toList();
  }

  void addCase({
    required String name,
    required SBViewportBuilder build,
  }) {
    _cases[name] = SBStoryCase(story: this, name: name, build: build);
  }

  SBStoryCase? getCase(String caseName) {
    return _cases[caseName];
  }
}

class SBStoryCase {
  final SBStory story;
  final String name;
  final SBViewportBuilder build;

  SBStoryCase({
    required this.story,
    required this.name,
    required this.build,
  });
}
