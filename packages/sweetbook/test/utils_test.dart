import 'package:flutter/material.dart';
import 'package:sweetbook/src/utils.dart';
import 'package:sweetbook/sweetbook.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('filterFolder', () {
    test('root folder is empty', () {
      final rootFolder = SBFolder(
        isRoot: true,
        title: '',
        children: [],
        stories: [],
      );

      final result = filterFolder(rootFolder, (_) => true);

      expect(result.children.length, 0);
      expect(result.stories.length, 0);
    });

    test('root folder has many story cases', () {
      final testStory = SBStory(storyPath: 'test')
        ..addCase(name: 'test1', builder: (_) => Container())
        ..addCase(name: 'test2', builder: (_) => Container());

      final rootFolder = SBFolder(
        isRoot: true,
        title: '',
        children: [],
        stories: [testStory],
      );

      final result = filterFolder(
        rootFolder,
        (storyCase) => storyCase.name == 'test1',
      );

      expect(result.children.length, 0);
      expect(result.stories.length, 1);
      expect(result.stories[0].cases.length, 1);
      expect(result.stories[0].cases[0], testStory.getCase('test1'));
    });

    test('root folder has many stories', () {
      final testStory1 = SBStory(storyPath: 'test')
        ..addCase(name: 'test1', builder: (_) => Container())
        ..addCase(name: 'test2', builder: (_) => Container());

      final testStory2 = SBStory(storyPath: 'test')
        ..addCase(name: 'test3', builder: (_) => Container())
        ..addCase(name: 'test4', builder: (_) => Container());

      final rootFolder = SBFolder(
        isRoot: true,
        title: '',
        children: [],
        stories: [
          testStory1,
          testStory2,
        ],
      );

      final result = filterFolder(
        rootFolder,
        (storyCase) => storyCase.name == 'test1',
      );

      expect(result.children.length, 0);
      expect(result.stories.length, 1);
      expect(result.stories[0].cases.length, 1);
      expect(result.stories[0].cases[0], testStory1.getCase('test1'));
    });

    test('root folder with nested folder with some cases', () {
      final testStory1 = SBStory(storyPath: 'test')
        ..addCase(name: 'test1', builder: (_) => Container())
        ..addCase(name: 'test2', builder: (_) => Container());

      final testStory2 = SBStory(storyPath: 'test')
        ..addCase(name: 'test3', builder: (_) => Container())
        ..addCase(name: 'test4', builder: (_) => Container());

      final testFolder = SBFolder(
        title: 'test_folder',
        isRoot: false,
        children: [],
        stories: [testStory2],
      );

      final rootFolder = SBFolder(
        isRoot: true,
        title: '',
        children: [testFolder],
        stories: [testStory1],
      );

      final result = filterFolder(
        rootFolder,
        (storyCase) => storyCase.name == 'test4',
      );

      expect(result.children.length, 1);
      expect(result.stories.length, 0);
      expect(result.children[0].stories.length, 1);
      expect(result.children[0].stories[0].cases.length, 1);
      expect(
          result.children[0].stories[0].cases[0], testStory2.getCase('test4'));
    });

    test('many linear nested folders with some story cases to find', () {
      final testStory = SBStory(storyPath: 'A/B/C/D')
        ..addCase(name: 'testStory1', builder: (_) => Container());

      final rootFolder = getFoldersTree([testStory]);

      final result = filterFolder(
        rootFolder,
        (storyCase) => storyCase.name == 'testStory1',
      );

      expect(result.children.length, 1);
      expect(result.name, 'root');
      expect(result.children[0].children.length, 1);
      expect(result.children[0].name, 'A');
      expect(result.children[0].children[0].children.length, 1);
      expect(result.children[0].children[0].name, 'B');
      expect(result.children[0].children[0].children[0].stories.length, 1);
      expect(result.children[0].children[0].children[0].name, 'C');
      expect(result.children[0].children[0].children[0].stories[0].name, 'D');
      expect(result.children[0].children[0].children[0].stories[0].cases.length,
          1);
      expect(
        result.children[0].children[0].children[0].stories[0].cases[0],
        testStory.getCase('testStory1'),
      );
    });

    test('many linear nested folders without story cases to find', () {
      final testStory = SBStory(storyPath: 'A/B/C/D')
        ..addCase(name: 'testStory1', builder: (_) => Container());

      final rootFolder = getFoldersTree([testStory]);

      final result = filterFolder(
        rootFolder,
        (storyCase) => storyCase.name == 'nope',
      );

      expect(result.children.length, 0);
    });

    test('root folder with many nested folders with some cases', () {
      final testStory1 = SBStory(storyPath: 'A/B/C')
        ..addCase(name: 'testStory1', builder: (_) => Container());

      final testStory2 = SBStory(storyPath: 'A/B/D')
        ..addCase(name: 'testStory2', builder: (_) => Container());

      final testStory3 = SBStory(storyPath: 'C/E/F')
        ..addCase(name: 'testStory3', builder: (_) => Container());

      final rootFolder = getFoldersTree([testStory1, testStory2, testStory3]);

      final result = filterFolder(
        rootFolder,
        (storyCase) =>
            storyCase.name == 'testStory1' || storyCase.name == 'testStory3',
      );

      expect(result.children.length, 2);
      expect(result.children[0].name, 'A');
      expect(result.children[0].children.length, 1);
      expect(result.children[0].children[0].name, 'B');
      expect(result.children[0].children[0].stories.length, 1);
      expect(result.children[0].children[0].stories[0].name, 'C');
      expect(result.children[0].children[0].stories[0].cases.length, 1);
      expect(
        result.children[0].children[0].stories[0].cases[0],
        testStory1.getCase('testStory1'),
      );

      expect(result.children[1].name, 'C');
      expect(result.children[1].children.length, 1);
      expect(result.children[1].children[0].name, 'E');
      expect(result.children[1].children[0].stories.length, 1);
      expect(result.children[1].children[0].stories[0].name, 'F');
      expect(result.children[1].children[0].stories[0].cases.length, 1);
      expect(
        result.children[1].children[0].stories[0].cases[0],
        testStory3.getCase('testStory3'),
      );
    });

    test('bubbling', () {
      final testStory1 = SBStory(storyPath: 'A/B/C/D')
        ..addCase(name: 'testStory1', builder: (_) => Container());

      final testStory2 = SBStory(storyPath: 'A/B/E/F')
        ..addCase(name: 'testStory2', builder: (_) => Container());

      final testStory3 = SBStory(storyPath: 'H/J/K/L')
        ..addCase(name: 'testStory3', builder: (_) => Container());

      final rootFolder = getFoldersTree([testStory1, testStory2, testStory3]);

      final result = filterFolder(
        rootFolder,
        (storyCase) =>
            storyCase.name == 'testStory2' || storyCase.name == 'testStory3',
      );

      expect(result.children.length, 2);
      expect(result.children[0].name, 'A');
      expect(result.children[0].children.length, 1);
      expect(result.children[0].children[0].name, 'B');
      expect(result.children[0].children[0].children.length, 1);
      expect(result.children[0].children[0].children[0].name, 'E');
      expect(result.children[0].children[0].children[0].children.length, 0);
      expect(result.children[0].children[0].children[0].stories.length, 1);
      expect(result.children[0].children[0].children[0].stories[0].name, 'F');
      expect(result.children[0].children[0].children[0].stories[0].cases.length,
          1);
      expect(result.children[0].children[0].children[0].stories[0].cases[0],
          testStory2.getCase('testStory2'));

      expect(result.children[1].name, 'H');
      expect(result.children[1].children.length, 1);
      expect(result.children[1].children[0].name, 'J');
      expect(result.children[1].children[0].children.length, 1);
      expect(result.children[1].children[0].children[0].name, 'K');
      expect(result.children[1].children[0].children[0].children.length, 0);
      expect(result.children[1].children[0].children[0].stories.length, 1);
      expect(result.children[1].children[0].children[0].stories[0].name, 'L');
      expect(result.children[1].children[0].children[0].stories[0].cases.length,
          1);
      expect(result.children[1].children[0].children[0].stories[0].cases[0],
          testStory3.getCase('testStory3'));
    });
  });
}
