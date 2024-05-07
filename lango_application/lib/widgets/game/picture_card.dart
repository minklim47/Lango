import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lango_application/theme/color_theme.dart';

enum CardState { normal, correct, wrong }

class PictureCard extends StatelessWidget {
  final String word;
  final String image;
  final CardState cardState;

  const PictureCard(
      {super.key,
      required this.word,
      required this.image,
      this.cardState = CardState.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
            height: 180,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
                border: Border.all(color: getBackgroundColor(cardState))),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(word),
                    const SizedBox(height: 10),
                    Image.asset("assets/images/game/$image.png", height: 100)
                  ],
                )))));
  }

  Color getBackgroundColor(CardState state) {
    switch (state) {
      case CardState.correct:
        return Colors.green; // Change to your desired color for collect state
      case CardState.wrong:
        return Colors.red; // Change to your desired color for wrong state
      case CardState.normal:
      default:
        return AppColors.white; // Change to your desired color for normal state
    }
  }
}
