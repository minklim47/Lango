import 'package:flutter/material.dart';
//import 'package:lango_application/theme/color_theme.dart';

class LangBox extends StatelessWidget {
  final String title;
  final String image;

  const LangBox({
    super.key,
    required this.title,
    required this.image,
  });


@override
Widget build(BuildContext context) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/images/language/$image.png"),
          fit: BoxFit.cover, // Ensure the image covers the entire box
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 1, 
            left: 14,
            //right: 1,
            child: Container(
              //color: Colors.black.withOpacity(0.5), 
              padding: const EdgeInsets.all(8), // Add padding for better appearance
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 32, 
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}