import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

class WordCard extends StatelessWidget {
  final String word;
  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          width: double.maxFinite,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: AppColors.white),
          child: Center(child: Text(word)),
        ));
  }
}
