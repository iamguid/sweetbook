import 'package:flutter/material.dart';
import 'package:sweetbook/src/widgets/catalog/catalog.dart';
import 'package:sweetbook/sweetbook.dart';

class StoryAppCatalogPageWidget extends StatelessWidget {
  final SBFolder rootFolder;

  StoryAppCatalogPageWidget({
    super.key,
    required this.rootFolder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: CatalogWidget(rootFolder: rootFolder),
      ),
    );
  }
}
