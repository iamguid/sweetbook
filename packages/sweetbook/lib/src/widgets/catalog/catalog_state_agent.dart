import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogStateAgent extends StateAgent<CatalogState, BaseEvent> {
  CatalogStateAgent() : super(CatalogState.empty());

  void onFolderPress(SBFolder folder) {
    toggleExpandedNode(folder);
  }

  void onStoryPress(SBStory story) {
    toggleExpandedNode(story);
  }

  void onStoryCasePress(SBStoryCase storyCase) {
    final newState = CatalogState(
      expandedNodes: state.expandedNodes,
      currentSelectedStoryCase: storyCase,
    );

    nextState(newState);
  }

  void toggleExpandedNode(SBCatalogNode node) {
    final newState = CatalogState(
      expandedNodes: Set.from(state.expandedNodes),
      currentSelectedStoryCase: state.currentSelectedStoryCase,
    );

    if (newState.expandedNodes.contains(node)) {
      newState.expandedNodes.remove(node);
    } else {
      newState.expandedNodes.add(node);
    }

    nextState(newState);
  }

  @override
  void onEvent(event) {
    if (event is GlobalEventStoryCaseChanged) {
      onStoryCasePress(event.payload);
    }

    if (event is CatalogFolderPressEvent) {
      onFolderPress(event.payload);
    }

    if (event is CatalogStoryPressEvent) {
      onStoryPress(event.payload);
    }

    if (event is CatalogStoryCasePressEvent) {
      onStoryCasePress(event.payload);
    }
  }
}
