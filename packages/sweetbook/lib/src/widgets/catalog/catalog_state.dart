import 'package:sweetbook/sweetbook.dart';

class CatalogState {
  final Set<String> expandedNodesPath;
  final String filterString;
  final bool allExapanded;
  final SBStoryCase? currentSelectedStoryCase;

  const CatalogState({
    required this.expandedNodesPath,
    required this.filterString,
    required this.allExapanded,
    required this.currentSelectedStoryCase,
  });

  factory CatalogState.empty() {
    return CatalogState(
      allExapanded: false,
      expandedNodesPath: {},
      filterString: '',
      currentSelectedStoryCase: null,
    );
  }
}
