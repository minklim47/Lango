import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

enum LangState {normal, click}

class LevelBox extends StatelessWidget {
  final String title;
  final String image;
  final LangState langState;

  const LevelBox({Key? key, required this.title, required this.image, required this.langState});

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width / 2; // Assuming 2 columns in the grid
    double containerHeight = MediaQuery.of(context).size.width / 2; // Adjust as needed

    return Container(
      width: containerWidth,
      height: containerHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: getBackgroundColor(langState)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14), // Adjust font size as needed
          ),
          SizedBox(height: 5),
          Expanded(
            child: Image.asset(
              "assets/images/survey/yourlevel/$image.png",
              fit: BoxFit.contain, // Ensure the image fits within the container
            ),
          ),
        ],
      ),
    );
  }

  Color getBackgroundColor(LangState state) {
    switch (state) {
      case LangState.click:
        return Colors.green; // Change to your desired color for collect state
      case LangState.normal:
      default:
        return AppColors.white; // Change to your desired color for normal state
    }
  }
}
