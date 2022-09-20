import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/src/widgets/catalog/catalog.dart';
import 'package:sweetbook/src/widgets/header/header.dart';
import 'package:sweetbook/src/widgets/viewport/viewport.dart';
import 'package:sweetbook/sweetbook.dart';

class CatalogAppWidget extends StatelessWidget {
  final SBFolder rootFolder;
  final SBAppConfig appConfig;
  final List<SBViewport> viewports;

  const CatalogAppWidget({
    super.key,
    required this.rootFolder,
    required this.appConfig,
    required this.viewports,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints.expand(height: 60),
            child: HeaderWidget(appConfig: appConfig, viewports: viewports),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints.expand(width: 300),
                  child: CatalogWidget(rootFolder: rootFolder),
                ),
                SizedBox(width: 10),
                Expanded(child: ViewportWidget()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
