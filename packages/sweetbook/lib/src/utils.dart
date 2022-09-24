import 'package:sweetbook/sweetbook.dart';

SBFolder getFoldersTree(List<SBStory> stories) {
  final Map<String, List<SBStory>> storiesMap = {};
  final Map<String, SBFolder> allFoldersMap = {};

  final rootFolder = SBFolder(
    title: 'root',
    children: [],
    stories: [],
    isRoot: true,
  );

  // Root folder has no parent
  rootFolder.parent = null;

  // Add root folder with empty path
  allFoldersMap[''] = rootFolder;

  for (var story in stories) {
    // Create stories list with story path it is not exist
    if (storiesMap[story.storyPath] == null) {
      storiesMap[story.storyPath] = [];
    }

    // Add story to stories list with the same path
    storiesMap[story.storyPath]!.add(story);
    final splittedFullPath = story.storyPath.split('/');

    // Remove story name from folder path
    splittedFullPath.removeLast();

    // Set initial state
    SBFolder currFolder = rootFolder;
    List<String> splittedCurrFolderPath = [];

    while (splittedFullPath.isNotEmpty) {
      splittedCurrFolderPath.add(splittedFullPath.removeAt(0));
      final String currFolderPath = splittedCurrFolderPath.join('/');

      // If folder is new
      if (allFoldersMap[currFolderPath] == null) {
        // Create emty new folder
        final newFolder = SBFolder(
          title: splittedCurrFolderPath.last,
          children: [],
          stories: [],
          isRoot: false,
        );

        // Set folder parent
        newFolder.parent = currFolder;

        // Add new folder to current folder children
        currFolder.children.add(newFolder);

        // Save folder in map
        allFoldersMap[currFolderPath] = newFolder;

        // Change currFolder to new folder
        currFolder = newFolder;
      } else {
        // Get existing folder
        final existiongFolder = allFoldersMap[currFolderPath]!;

        // Change currFolder to existing folder
        currFolder = existiongFolder;
      }
    }

    // Set story parent
    story.parent = currFolder;

    // Add story to current folder
    currFolder.stories.add(story);
  }

  return rootFolder;
}

SBStory filterStory(
  SBStory story,
  bool Function(SBStoryCase storyCase) predicate,
) {
  final filteredStoryCases = story.cases.where(predicate).toList();
  final newStory = SBStory(storyPath: story.storyPath);

  if (filteredStoryCases.isNotEmpty) {
    newStory.addCases(filteredStoryCases);
  }

  return newStory;
}

SBFolder filterFolder(
  SBFolder rootFolder,
  bool Function(SBStoryCase storyCase) predicate,
) {
  final List<SBFolder> filteredFolders = [];
  final List<SBFolder> newFolders = [];

  final newRootFolder = SBFolder(
    title: rootFolder.title,
    isRoot: rootFolder.isRoot,
    children: [],
    stories: [],
  );

  final rootFilteredStories = rootFolder.stories
      .map((story) => filterStory(story, predicate))
      .where((story) => story.cases.isNotEmpty);

  newRootFolder.stories.addAll(rootFilteredStories);

  filteredFolders.addAll(rootFolder.children.reversed);

  while (filteredFolders.isNotEmpty) {
    final currentFilteredFolder = filteredFolders.removeLast();

    if (newFolders.isEmpty) {
      newFolders.add(newRootFolder);
    }

    newFolders.add(SBFolder(
      title: currentFilteredFolder.title,
      isRoot: currentFilteredFolder.isRoot,
      children: [],
      stories: [],
    ));

    for (var story in currentFilteredFolder.stories) {
      final newStory = filterStory(story, predicate);

      if (newStory.cases.isNotEmpty) {
        var prevNewFolder = newFolders.removeLast();
        prevNewFolder.stories.add(newStory);

        SBFolder currentNewFolder = newRootFolder;

        if (newFolders.isNotEmpty) {
          while (newFolders.isNotEmpty) {
            currentNewFolder = newFolders.removeLast();
            currentNewFolder.children.add(prevNewFolder);
            prevNewFolder = currentNewFolder;
          }
        } else {
          currentNewFolder.children.add(prevNewFolder);
        }
      }
    }

    if (currentFilteredFolder.children.isEmpty && newFolders.isNotEmpty) {
      newFolders.removeLast();
    }

    filteredFolders.addAll(currentFilteredFolder.children.reversed);
  }

  return newRootFolder;
}
