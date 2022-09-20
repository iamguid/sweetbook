import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/sweetbook.dart';

abstract class GlobalEvent<T> extends PayloadedEvent<T> {
  GlobalEvent(super.payload);
}

class GlobalEventViewportChanged extends GlobalEvent<SBViewport> {
  GlobalEventViewportChanged(super.payload);
}

class GlobalEventStoryCaseChanged extends GlobalEvent<SBStoryCase> {
  GlobalEventStoryCaseChanged(super.payload);
}
