import 'package:sweetbook/sweetbook.dart';

class CatalogState {
  final Set<SBCatalogNode> expandedNodes;
  final SBStoryCase? currentSelectedStoryCase;

  const CatalogState({
    required this.expandedNodes,
    required this.currentSelectedStoryCase,
  });

  factory CatalogState.empty() {
    return CatalogState(
      expandedNodes: {},
      currentSelectedStoryCase: null,
    );
  }
}
