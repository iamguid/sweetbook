import 'package:flutter/material.dart';
import 'package:sweetbook/src/widgets/viewport/viewport.dart';

class StoryAppCasePageWidget extends StatelessWidget {
  StoryAppCasePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewportWidget(),
    );
  }
}
