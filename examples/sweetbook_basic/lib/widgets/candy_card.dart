import 'package:flutter/material.dart';
import 'package:sweetbook_basic/models/candy_model.dart';

class CandyCard extends StatelessWidget {
  final CandyModel model;

  const CandyCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(model.title),
          Image.asset(model.picturePath),
          Text(model.price.toString()),
        ],
      ),
    );
  }
}
