import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/sweetbook.dart';

enum SBAppMode {
  catalog,
  story,
}

abstract class GlobalEvent<T> extends PayloadEvent<T> {
  GlobalEvent(super.payload);
}

class ViewportChanged extends GlobalEvent<SBViewport> {
  ViewportChanged(super.payload);
}

class StoryCaseChanged extends GlobalEvent<SBStoryCase> {
  StoryCaseChanged(super.payload);
}

class ModeChanged extends GlobalEvent<SBAppMode> {
  ModeChanged(super.payload);
}

class BackToCatalog extends GlobalEvent<void> {
  BackToCatalog() : super(null);
}
