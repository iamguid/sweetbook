import 'package:flutter/material.dart';
import 'package:sweetbook/sweetbook.dart';

typedef SBViewportBuilder = Widget Function(SBContext context);

Widget developmentViewportBuilder(SBContext context) {
  return SafeArea(
    child: FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: context.currentStoryCase?.build(context),
      ),
    ),
  );
}
