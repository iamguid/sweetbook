import 'package:sweetbook/sweetbook.dart';
import 'package:sweetbook_basic/models/candy_model.dart';
import 'package:sweetbook_basic/sweetbook/main.dart';
import 'package:sweetbook_basic/widgets/candies_list.dart';

void main(List<String> args) {
  runStory(candiesListStory);
}

final candiesListStory = SBStory(storyPath: 'CandiesList')
  ..addCase(
    name: 'default',
    builder: (context) => CandiesList(
      candies: [
        CandyModel(
          title: 'Chocolate',
          price: 1,
          picturePath: 'assets/chocolate.jpeg',
        ),
        CandyModel(
          title: 'Croissant',
          price: 1,
          picturePath: 'assets/croissant.jpeg',
        ),
        CandyModel(
          title: 'Icecream',
          price: 1,
          picturePath: 'assets/icecream.jpeg',
        ),
        CandyModel(
          title: 'Donut',
          price: 1,
          picturePath: 'assets/donut.jpeg',
        ),
      ],
    ),
  );
