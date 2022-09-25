import 'package:sweetbook/src/global_events.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogState {
  final Set<String> expandedNodesPath;
  final String filterString;
  final bool allExapanded;
  final SBAppMode mode;
  final SBStoryCase? currentSelectedStoryCase;

  const CatalogState({
    required this.expandedNodesPath,
    required this.filterString,
    required this.allExapanded,
    required this.mode,
    required this.currentSelectedStoryCase,
  });

  factory CatalogState.empty() {
    return CatalogState(
      allExapanded: false,
      expandedNodesPath: {},
      mode: SBAppMode.catalog,
      filterString: '',
      currentSelectedStoryCase: null,
    );
  }
}
