import 'dart:math';

import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/widgets/catalog/catalog.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_story_case.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogStoryWidget extends StatelessWidget {
  final SBStory story;

  const CatalogStoryWidget(this.story);

  List<Widget> buildStoryItems(SBStory story) {
    return story.cases
        .map((storyCase) => CatalogStoryCaseWidget(storyCase))
        .toList();
  }

  Widget buildStory(BuildContext context, SBStory story) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);
    final isExpanded =
        catalogStateAgent.state.expandedNodesPath.contains(story.path) ||
            catalogStateAgent.state.allExapanded;

    return InkWell(
      onTap: () => catalogStateAgent.emit('catalog', StoryTapEvent(story)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: catalogElementsVerticalPadding),
        child: Padding(
          padding: EdgeInsets.only(left: story.deep * catalogDeepLeftPadding),
          child: Row(
            children: [
              Icon(
                Icons.auto_stories_outlined,
                size: 17,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 10),
              Text(
                story.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox(width: 5),
              Transform.rotate(
                angle: isExpanded ? 0 : -pi / 2,
                child: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);
    final isExpanded =
        catalogStateAgent.state.expandedNodesPath.contains(story.path) ||
            catalogStateAgent.state.allExapanded;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStory(context, story),
        Padding(
          padding: EdgeInsets.only(left: story.deep * catalogDeepLeftPadding),
          child: isExpanded
              ? ListView(
                  shrinkWrap: true,
                  children: buildStoryItems(story),
                )
              : Container(),
        ),
      ],
    );
  }
}
