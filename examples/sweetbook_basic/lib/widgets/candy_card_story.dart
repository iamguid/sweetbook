import 'package:sweetbook/sweetbook.dart';
import 'package:sweetbook_basic/models/candy_model.dart';
import 'package:sweetbook_basic/sweetbook/main.dart';
import 'package:sweetbook_basic/widgets/candy_card.dart';

void main(List<String> args) {
  runStory(candyCardStory);
}

final candyCardStory = SBStory(storyPath: 'Candies/CandyCard')
  ..addCase(
    name: 'chocolate',
    decorator: const CenterDecorator(),
    builder: (context) => CandyCard(
      model: CandyModel(
        title: 'Chocolate',
        price: 1,
        picturePath: 'assets/chocolate.jpeg',
      ),
    ),
  )
  ..addCase(
    name: 'cruissant',
    decorator: const CenterDecorator(),
    builder: (context) => CandyCard(
      model: CandyModel(
        title: 'Cruissant',
        price: 1,
        picturePath: 'assets/croissant.jpeg',
      ),
    ),
  )
  ..addCase(
    name: 'icecream',
    decorator: const CenterDecorator(),
    builder: (context) => CandyCard(
      model: CandyModel(
        title: 'Icecream',
        price: 1,
        picturePath: 'assets/icecream.jpeg',
      ),
    ),
  )
  ..addCase(
    name: 'donut',
    decorator: const CenterDecorator(),
    builder: (context) => CandyCard(
      model: CandyModel(
        title: 'Donut',
        price: 1,
        picturePath: 'assets/donut.jpeg',
      ),
    ),
  );
