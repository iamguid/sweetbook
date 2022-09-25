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
      child: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(model.title,
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            Expanded(
              child: Image.asset(model.picturePath),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price: ${model.price.toString()}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
