import 'package:flutter/material.dart';
import 'package:sweetbook/sweetbook.dart';

abstract class SBViewport {
  final String title;

  Widget build(SBViewportState state, Widget widget);

  SBViewport({
    required this.title,
  });
}
