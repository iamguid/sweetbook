import 'package:flutter/material.dart';
import 'package:sweetbook/sweetbook.dart';
import 'package:sweetbook_basic/widgets/candies_list_story.dart';
import 'package:sweetbook_basic/widgets/candy_card_story.dart';

final defaultTheme = ThemeData.dark();
final defaultAppConfig = SBAppConfig(title: 'candyshop', theme: defaultTheme);
final allStroies = <SBStory>[candyCardStory, candiesListStory];
final devViewport = SBDevelopmentViewport(title: 'TEST');

void main(List<String> args) {
  runCatalog(allStroies);
}

void runCatalog(List<SBStory> stories) {
  runApp(
    Sweetbook(
      stories,
      appConfig: defaultAppConfig,
      viewports: [devViewport],
    ),
  );
}

void runStory(SBStory storie) {
  runApp(
    Sweetbook.story(
      storie,
      appConfig: defaultAppConfig,
      viewport: devViewport,
    ),
  );
}
