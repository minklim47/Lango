import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/game/picture_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';

class PictureMatchPage extends StatefulWidget {
  const PictureMatchPage({super.key});

  @override
  State<PictureMatchPage> createState() => _PictureMatchPageState();
}

class _PictureMatchPageState extends State<PictureMatchPage> {
  int _selectCardIndex = -1;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void handleCardTap(int index) {
    if (_selectCardIndex == -1) {
      setState(() {
        _selectCardIndex = index;
      });
      if (_selectCardIndex == 0) {
        _confettiController.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        ),
        Row(children: [
          const Expanded(
              child: ProgressBar(
            max: 100,
            current: 0,
            height: 20,
          )),
          IconButton(
              onPressed: () => {context.go("/")},
              icon: const Icon(Icons.close)),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          child: Text(
            "Which one of these is “แอปเปิ้ล”",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        MediaQuery.of(context).size.width < 375
            ? Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () => handleCardTap(0),
                            child: const PictureCard(
                              word: "apple",
                              image: "apple",
                            )),
                        GestureDetector(
                            onTap: () => handleCardTap(1),
                            child: const PictureCard(
                              word: "pink",
                              image: "pink",
                            )),
                        GestureDetector(
                            onTap: () => handleCardTap(2),
                            child: const PictureCard(
                              word: "banana",
                              image: "banana",
                            )),
                      ],
                    ),
                  ),
                ),
              )
            : Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              GestureDetector(
                                  onTap: () => handleCardTap(0),
                                  child: PictureCard(
                                    cardState: _selectCardIndex != -1
                                        ? CardState.correct
                                        : CardState.normal,
                                    word: "apple",
                                    image: "apple",
                                  )),
                              GestureDetector(
                                  onTap: () => handleCardTap(1),
                                  child: PictureCard(
                                    cardState: _selectCardIndex == 1
                                        ? CardState.wrong
                                        : CardState.normal,
                                    word: "pink",
                                    image: "pink",
                                  )),
                            ])),
                        GestureDetector(
                            onTap: () => handleCardTap(2),
                            child: PictureCard(
                              cardState: _selectCardIndex == 2
                                  ? CardState.wrong
                                  : CardState.normal,
                              word: "banana",
                              image: "banana",
                            )),
                      ],
                    ),
                  ),
                ),
              ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: IgnorePointer(
                ignoring: _selectCardIndex == -1,
                child: ElevatedButton(
                  onPressed: () => context.go("/game/word"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _selectCardIndex == -1 ? Colors.grey : AppColors.yellow,
                    ),
                  ),
                  child: const Text("CONTINUE"),
                ),
              ),
            ))
      ])),
    );
  }
}
