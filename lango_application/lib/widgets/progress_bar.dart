import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

class ProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final double? height;

  const ProgressBar(
      {super.key,
      required this.max,
      required this.current,
      this.color = AppColors.green,
      this.height});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: height ?? 10,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: height ?? 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
