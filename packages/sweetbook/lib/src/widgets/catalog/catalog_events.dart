import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/sweetbook.dart';

abstract class CatalogEvent<T> extends PayloadedEvent<T> {
  CatalogEvent(super.payload);
}

class CatalogFolderPressEvent extends CatalogEvent<SBFolder> {
  CatalogFolderPressEvent(super.payload);
}

class CatalogStoryPressEvent extends CatalogEvent<SBStory> {
  CatalogStoryPressEvent(super.payload);
}

class CatalogStoryCasePressEvent extends CatalogEvent<SBStoryCase> {
  CatalogStoryCasePressEvent(super.payload);
}

class CatalogSearchStringChanged extends CatalogEvent<String> {
  CatalogSearchStringChanged(super.payload);
}
