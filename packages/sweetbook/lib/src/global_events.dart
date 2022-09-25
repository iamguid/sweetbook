import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/sweetbook.dart';

enum SBAppMode {
  catalog,
  story,
}

abstract class GlobalEvent<T> extends PayloadedEvent<T> {
  GlobalEvent(super.payload);
}

class GlobalEventViewportChanged extends GlobalEvent<SBViewport> {
  GlobalEventViewportChanged(super.payload);
}

class GlobalEventStoryCaseChanged extends GlobalEvent<SBStoryCase> {
  GlobalEventStoryCaseChanged(super.payload);
}

class GlobalEventModeChanged extends GlobalEvent<SBAppMode> {
  GlobalEventModeChanged(super.payload);
}

class GlobalEventBackToCatalog extends GlobalEvent<void> {
  GlobalEventBackToCatalog() : super(null);
}
