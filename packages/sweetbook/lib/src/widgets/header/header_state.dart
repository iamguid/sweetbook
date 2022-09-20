import 'package:sweetbook/src/abstract/viewport.dart';

class HeaderState {
  final SBViewport? selectedViewport;

  HeaderState({
    required this.selectedViewport,
  });

  factory HeaderState.empty() {
    return HeaderState(selectedViewport: null);
  }
}
