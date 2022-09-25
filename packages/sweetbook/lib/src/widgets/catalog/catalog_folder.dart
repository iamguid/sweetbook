import 'dart:math';

import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/catalog_app_agent.dart';
import 'package:sweetbook/src/widgets/catalog/catalog.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_story.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogFolderWidget extends StatelessWidget {
  final SBFolder folder;

  const CatalogFolderWidget(this.folder);

  List<Widget> buildFolderItems(BuildContext context, SBFolder folder) {
    final List<Widget> result = [];

    result.addAll(folder.children.map((e) => CatalogFolderWidget(e)));
    result.addAll(folder.stories.map((e) => CatalogStoryWidget(e)));

    return result;
  }

  Widget buildFolder(BuildContext context, SBFolder folder) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);
    final isExpanded =
        catalogStateAgent.state.expandedNodesPath.contains(folder.path) ||
            catalogStateAgent.state.allExapanded;

    return InkWell(
      onTap: () => catalogStateAgent.dispatch(CatalogFolderPressEvent(folder)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: catalogElementsVerticalPadding),
        child: Padding(
          padding: EdgeInsets.only(left: folder.deep * catalogDeepLeftPadding),
          child: Row(
            children: [
              Icon(
                Icons.folder_outlined,
                size: 17,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 10),
              Text(
                folder.title,
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
        catalogStateAgent.state.expandedNodesPath.contains(folder.path) ||
            catalogStateAgent.state.allExapanded;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFolder(context, folder),
        Padding(
          padding: EdgeInsets.only(left: folder.deep * catalogDeepLeftPadding),
          child: isExpanded
              ? ListView(
                  shrinkWrap: true,
                  children: buildFolderItems(context, folder),
                )
              : Container(),
        ),
      ],
    );
  }
}
