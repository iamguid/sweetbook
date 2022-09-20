import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/viewport.dart';
import 'package:sweetbook/sweetbook.dart';

class SBDevelopmentViewport extends SBViewport {
  SBDevelopmentViewport({required super.title});

  @override
  Widget build(SBViewportState state, Widget widget) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: widget,
      ),
    );
  }
}
