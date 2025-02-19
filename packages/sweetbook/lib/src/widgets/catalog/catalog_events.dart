import 'package:sweetbook/src/base_event.dart';
import 'package:sweetbook/sweetbook.dart';

abstract class CatalogEvent<T> extends PayloadEvent<T> {
  CatalogEvent(super.payload);
}

class FolderTapEvent extends CatalogEvent<SBFolder> {
  FolderTapEvent(super.payload);
}

class StoryTapEvent extends CatalogEvent<SBStory> {
  StoryTapEvent(super.payload);
}

class StoryCaseTapEvent extends CatalogEvent<SBStoryCase> {
  StoryCaseTapEvent(super.payload);
}

class SearchStringChanged extends CatalogEvent<String> {
  SearchStringChanged(super.payload);
}
