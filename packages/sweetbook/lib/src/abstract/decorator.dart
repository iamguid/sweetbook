import 'package:flutter/material.dart';
import 'package:sweetbook/sweetbook.dart';

abstract class SBDecorator {
  const SBDecorator();

  Widget build(SBViewportState state, Widget widget);
}
