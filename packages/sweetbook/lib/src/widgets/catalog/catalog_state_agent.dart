import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogStateAgent extends StateAgent<CatalogState, BaseEvent> {
  CatalogStateAgent() : super(CatalogState.empty()) {
    on<GlobalEventModeChanged>(onAppModeChanged);
    on<GlobalEventStoryCaseChanged>(onStoryCaseChanged);
    on<CatalogSearchStringChanged>(onSearchStringChanged);
    on<CatalogFolderPressEvent>(onFolderPress);
    on<CatalogStoryPressEvent>(onStoryPress);
    on<CatalogStoryCasePressEvent>(onStoryCasePress);
  }

  void onAppModeChanged(GlobalEventModeChanged event) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: event.payload == SBAppMode.story,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: event.payload,
      filterString: state.filterString,
    );

    nextState(newState);
  }

  void onStoryCaseChanged(GlobalEventStoryCaseChanged event) {
    changeStoryCase(event.payload);
  }

  void onSearchStringChanged(CatalogSearchStringChanged event) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded:
          event.payload.isEmpty ? state.mode == SBAppMode.story : true,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: state.mode,
      filterString: event.payload,
    );

    nextState(newState);
  }

  void onFolderPress(CatalogFolderPressEvent event) {
    toggleExpandedNode(event.payload);
  }

  void onStoryPress(CatalogStoryPressEvent event) {
    toggleExpandedNode(event.payload);
  }

  void onStoryCasePress(CatalogStoryCasePressEvent event) {
    changeStoryCase(event.payload);
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

  void changeStoryCase(SBStoryCase storyCase) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: state.allExapanded,
      currentSelectedStoryCase: storyCase,
      mode: state.mode,
      filterString: state.filterString,
    );

    nextState(newState);
  }
}
