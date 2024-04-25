import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lango_application/theme/color_theme.dart';

class PictureCard extends StatelessWidget {
  final String word;
  final String image;
  const PictureCard({super.key, required this.word, required this.image});

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
            ),
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
}
