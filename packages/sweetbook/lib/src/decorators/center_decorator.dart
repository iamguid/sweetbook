import 'package:flutter/material.dart';
import 'package:sweetbook/src/abstract/decorator.dart';
import 'package:sweetbook/src/lib.dart';

class CenterDecorator extends SBDecorator {
  const CenterDecorator() : super();

  @override
  Widget build(SBViewportState state, Widget widget) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Spacer(),
        widget,
        Spacer(),
      ],
    );
  }
}
