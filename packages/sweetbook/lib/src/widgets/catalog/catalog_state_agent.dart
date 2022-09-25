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
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: state.allExapanded,
      currentSelectedStoryCase: storyCase,
      mode: state.mode,
      filterString: state.filterString,
    );

    nextState(newState);
  }

  void toggleExpandedNode(SBCatalogNode node) {
    final newState = CatalogState(
      expandedNodesPath: Set.from(state.expandedNodesPath),
      allExapanded: state.allExapanded,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: state.mode,
      filterString: state.filterString,
    );

    if (newState.expandedNodesPath.contains(node.path)) {
      newState.expandedNodesPath.remove(node.path);
    } else {
      newState.expandedNodesPath.add(node.path);
    }

    nextState(newState);
  }

  void onSearchStringChanged(String filterString) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: filterString.isEmpty ? state.mode == SBAppMode.story : true,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: state.mode,
      filterString: filterString,
    );

    nextState(newState);
  }

  void onAppModeChanged(SBAppMode mode) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: mode == SBAppMode.story,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: mode,
      filterString: state.filterString,
    );

    nextState(newState);
  }

  @override
  void onEvent(event) {
    if (event is GlobalEventModeChanged) {
      onAppModeChanged(event.payload);
    }

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

    if (event is CatalogSearchStringChanged) {
      onSearchStringChanged(event.payload);
    }
  }
}
