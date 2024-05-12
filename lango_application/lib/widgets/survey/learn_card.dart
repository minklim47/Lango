import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

enum ChooseState {normal, click}

class LearnBox extends StatelessWidget {
  final String title;
  final String image;
  final ChooseState chooseState;

  const LearnBox({super.key, this.title = "", this.image = "", this.chooseState = ChooseState.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: getBackgroundColor(chooseState))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 10),
          Image.asset(
            "assets/images/survey/learnfor/$image.png",
            height: 100,
          ),
        ],
      ),
    );
  }
}

  Color getBackgroundColor(ChooseState state) {
    switch (state) {
      case ChooseState.click:
        return Colors.green;
      case ChooseState.normal:
      default:
        return AppColors.white;
    }
  }


