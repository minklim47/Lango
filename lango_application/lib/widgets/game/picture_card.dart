import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/theme/color_theme.dart';

enum CardState { normal, correct, wrong }

class PictureCard extends StatefulWidget {
  final String word;
  final String image;
  final CardState cardState;

  const PictureCard(
      {super.key,
      required this.word,
      required this.image,
      this.cardState = CardState.normal});

  @override
  PictureCardState createState() => PictureCardState();
}

class PictureCardState extends State<PictureCard> {
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImageUrl();
  }

  @override
  void didUpdateWidget(covariant PictureCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      _fetchImageUrl();
    }
  }

  Future<void> _fetchImageUrl() async {
    if (widget.image.isEmpty) {
      setState(() {
        isLoading = true;
      });
      return;
    }

    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("game")
          .child("${widget.image}.png");

      String url = await ref.getDownloadURL();
      setState(() {
        imageUrl = url;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching image URL: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

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
                border:
                    Border.all(color: getBackgroundColor(widget.cardState))),
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.word),
                    const SizedBox(height: 10),
                    if (isLoading)
                      const CircularProgressIndicator()
                    else if (imageUrl != null)
                      Image.network(
                        imageUrl!,
                        height: 100,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/logos/lango_logo.png',
                            height: 100,
                          );
                        },
                      )
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
