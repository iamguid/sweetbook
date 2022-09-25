import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/decorator.dart';
import 'package:sweetbook/sweetbook.dart';

class JustDecorator extends SBDecorator {
  const JustDecorator() : super();

  @override
  Widget build(SBViewportState state, Widget widget) {
    return widget;
  }
}
