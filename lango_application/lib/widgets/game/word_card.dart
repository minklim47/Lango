import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/game/picture_card.dart';

class WordCard extends StatelessWidget {
  final String word;
  final CardState cardState;
  const WordCard(
      {super.key, required this.word, this.cardState = CardState.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          width: double.maxFinite,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            border: Border.all(color: getBackgroundColor(cardState)),
          ),
          child: Center(child: Text(word)),
        ));
  }

  Color getBackgroundColor(CardState state) {
    switch (state) {
      case CardState.correct:
        return Colors.green; 
      case CardState.wrong:
        return Colors.red; 
      case CardState.normal:
      default:
        return AppColors.white; 
    }
  }
}
