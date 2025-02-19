import 'package:agent_flutter/agent_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sweetbook/src/utils.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_folder.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state_agent.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_story.dart';
import 'package:sweetbook/sweetbook.dart';

const catalogDeepLeftPadding = 7.0;
const catalogElementsVerticalPadding = 10.0;

class CatalogWidget extends StatelessWidget {
  final SBFolder rootFolder;

  const CatalogWidget({
    required this.rootFolder,
  });

  List<Widget> buildRootItems(BuildContext context, SBFolder rootFolder) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);

    final filteredTree = filterFolder(rootFolder, (SBStoryCase storyCase) {
      return storyCase.name.contains(catalogStateAgent.state.filterString);
    });

    final folders = filteredTree.children
        .map((folder) => CatalogFolderWidget(folder))
        .toList();

    final stories =
        filteredTree.stories.map((story) => CatalogStoryWidget(story)).toList();

    return [...folders, ...stories];
  }

  @override
  Widget build(BuildContext context) {
    final catalogStateAgent = AgentProvider.of<CatalogStateAgent>(context);

    return StateAgentBuilder<CatalogStateAgent, CatalogState>(
      builder: (_, state) => Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: TextFormField(
                  onChanged: (value) => catalogStateAgent
                      .emit('catalog', SearchStringChanged(value)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Search...',
                  ),
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: buildRootItems(context, rootFolder),
            ),
          ],
        ),
      ),
    );
  }
}
