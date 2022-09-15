import 'package:flutter/material.dart';
import 'package:sweetbook_basic/models/candy_model.dart';
import 'package:sweetbook_basic/widgets/candy_card.dart';

class CandiesList extends StatelessWidget {
  final List<CandyModel> candies;

  const CandiesList({
    super.key,
    required this.candies,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: candies.map((c) => CandyCard(model: c)).toList(),
    );
  }
}
