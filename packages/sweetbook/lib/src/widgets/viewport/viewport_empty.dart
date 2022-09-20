import 'package:flutter/material.dart';

class ViewportEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text('Nothing Selected'),
    );
  }
}
