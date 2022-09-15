import 'package:flutter/material.dart';
import 'package:sweetbook/sweetbook.dart';
import 'package:sweetbook_basic/widgets/candy_card_story.dart';

final defaultTheme = ThemeData.dark();
final defaultAppConfig = SBAppConfig(title: 'candyshop', theme: defaultTheme);
final allStroies = <SBStory>[candyCardStory];

void main(List<String> args) {
  runStories(allStroies);
}

void runStory(SBStory story) {
  runApp(
    Sweetbook.story(
      story,
      appConfig: defaultAppConfig,
      builder: developmentViewportBuilder,
    ),
  );
}

void runStories(List<SBStory> stories) {
  runApp(
    Sweetbook(
      stories,
      appConfig: defaultAppConfig,
      builder: developmentViewportBuilder,
    ),
  );
}
