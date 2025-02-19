import 'package:agent_flutter/agent_flutter.dart';
import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_events.dart';
import 'package:sweetbook/src/widgets/catalog/catalog_state.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogStateAgent extends StateAgent<CatalogState> {
  CatalogStateAgent() : super(CatalogState.empty()) {
    on<ModeChanged>('global', onAppModeChanged);
    on<StoryCaseChanged>('global', onStoryCaseChanged);
    on<SearchStringChanged>('catalog', onSearchStringChanged);
    on<FolderTapEvent>('catalog', onFolderTap);
    on<StoryTapEvent>('catalog', onStoryTap);
    on<StoryCaseTapEvent>('catalog', onStoryCaseTap);
  }

  void onAppModeChanged(String topic, ModeChanged event) {
    final newState = CatalogState(
      expandedNodesPath: state.expandedNodesPath,
      allExapanded: event.payload == SBAppMode.story,
      currentSelectedStoryCase: state.currentSelectedStoryCase,
      mode: event.payload,
      filterString: state.filterString,
    );

    nextState(newState);
  }

  void onStoryCaseChanged(String topic, StoryCaseChanged event) {
    changeStoryCase(event.payload);
  }

  void onSearchStringChanged(String topic, SearchStringChanged event) {
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

  void onFolderTap(String topic, FolderTapEvent event) {
    toggleExpandedNode(event.payload);
  }

  void onStoryTap(String topic, StoryTapEvent event) {
    toggleExpandedNode(event.payload);
  }

  void onStoryCaseTap(String topic, StoryCaseTapEvent event) {
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
