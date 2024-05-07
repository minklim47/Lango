import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/game/picture_card.dart';
import 'package:lango_application/widgets/game/word_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';

class WordMatchPage extends StatefulWidget {
  const WordMatchPage({super.key});

  @override
  State<WordMatchPage> createState() => _WordMatchPageState();
}

class _WordMatchPageState extends State<WordMatchPage> {
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
      if (_selectCardIndex == 1) {
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
            current: 50,
            height: 20,
          )),
          IconButton(
              onPressed: () => {context.go("/")},
              icon: const Icon(Icons.close)),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Text(
            "How do you say “small”",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Expanded(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              GestureDetector(
                  onTap: () => handleCardTap(0),
                  child: WordCard(
                    word: "ใหญ่",
                    cardState: _selectCardIndex == 0
                        ? CardState.wrong
                        : CardState.normal,
                  )),
              GestureDetector(
                  onTap: () => handleCardTap(1),
                  child: WordCard(
                    word: "เล็ก",
                    cardState: _selectCardIndex != -1
                        ? CardState.correct
                        : CardState.normal,
                  )),
              GestureDetector(
                  onTap: () => handleCardTap(2),
                  child: WordCard(
                    word: "กลาง",
                    cardState: _selectCardIndex == 2
                        ? CardState.wrong
                        : CardState.normal,
                  ))
            ]))),
        if (MediaQuery.of(context).size.height > 500)
          SizedBox(height: MediaQuery.of(context).size.height / 10),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go("/game/pair"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    _selectCardIndex == -1 ? Colors.grey : AppColors.yellow,
                  ),
                ),
                child: const Text("CONTINUE"),
              ),
            ))
      ])),
    );
  }
}
