import 'package:sweetbook/sweetbook.dart';
import 'package:sweetbook_basic/models/candy_model.dart';
import 'package:sweetbook_basic/sweetbook/main.dart';
import 'package:sweetbook_basic/widgets/candy_card.dart';

void main(List<String> args) {
  runStory(candyCardStory);
}

final candyCardStory = SBStory(path: 'Candies/CandyCard')
  ..addCase(
    name: 'default',
    build: (context) => CandyCard(
      model: CandyModel(
        title: 'LollyPop',
        price: 1,
        picturePath: 'assets/lollypop.png',
      ),
    ),
  )
  ..addCase(
    name: 'long_title',
    build: (context) => CandyCard(
      model: CandyModel(
        title:
            'LongTitleLongTitleLongTitleLongTitleLongTitleLongTitleLongTitleLongTitleLongTitle',
        price: 1,
        picturePath: 'assets/lollypop.png',
      ),
    ),
  );
