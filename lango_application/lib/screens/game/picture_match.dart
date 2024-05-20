import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/game/picture_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class PictureMatchPage extends StatefulWidget {
  final String _level;
  final String _stage;
  final String _currentGame;

  const PictureMatchPage(
      {super.key,
      required String level,
      required String stage,
      required String game})
      : _level = level,
        _stage = stage,
        _currentGame = game;

  @override
  State<PictureMatchPage> createState() => _PictureMatchPageState();
}

class _PictureMatchPageState extends State<PictureMatchPage> {
  int _selectCardIndex = -1;
  late int _progress = int.parse(widget._currentGame);
  late int _totalQuestion = 1;
  late Question _question;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _question = Question(questionWord: "", answerIndex: -1, choice: [
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: "")
    ]);
    fetchQuestion();
  }

  void fetchQuestion() async {
    try {
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      await gameProvider.initData(widget._stage, widget._level);
      if (kDebugMode) {
        print("Current game");
        print(widget._currentGame);
      }
      setState(() {
        _question = gameProvider.questions[int.parse(widget._currentGame)];
        _totalQuestion = widget._stage == "12" ? 7 : 6;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
      if (_selectCardIndex == _question.answerIndex) {
        _confettiController.play();
        Provider.of<GameProvider>(context, listen: false).addPoint(10);
        setState(() {
          _progress++;
        });
      }
    }
  }

  void reloadQuestion() {
    fetchQuestion();
  }

  CardState cardStateCheck(int index) {
    if (_selectCardIndex == -1) {
      return CardState.normal;
    } else if (index == _question.answerIndex) {
      return CardState.correct;
    } else if (index == _selectCardIndex && index != _question.answerIndex) {
      return CardState.wrong;
    }
    return CardState.normal;
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
          Expanded(
              child: ProgressBar(
            max: _totalQuestion.toDouble(),
            current: _progress.toDouble(),
            height: 20,
          )),
          IconButton(
              onPressed: () => {
                    Provider.of<GameProvider>(context, listen: false)
                        .resetScore(),
                    context.go("/"),
                  },
              icon: const Icon(Icons.close)),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          child: Text(
            "Which one of these is “${_question.questionWord}”",
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
                            child: PictureCard(
                                word: _question.choice[0].other,
                                image: _question.choice[0].eng,
                                cardState: cardStateCheck(0))),
                        GestureDetector(
                            onTap: () => handleCardTap(1),
                            child: PictureCard(
                                word: _question.choice[1].other,
                                image: _question.choice[1].eng,
                                cardState: cardStateCheck(1))),
                        GestureDetector(
                            onTap: () => handleCardTap(2),
                            child: PictureCard(
                                word: _question.choice[2].other,
                                image: _question.choice[2].eng,
                                cardState: cardStateCheck(2))),
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
                                      word: _question.choice[0].other,
                                      image: _question.choice[0].eng,
                                      cardState: cardStateCheck(0))),
                              GestureDetector(
                                  onTap: () => handleCardTap(1),
                                  child: PictureCard(
                                      word: _question.choice[1].other,
                                      image: _question.choice[1].eng,
                                      cardState: cardStateCheck(1))),
                            ])),
                        GestureDetector(
                            onTap: () => handleCardTap(2),
                            child: PictureCard(
                                word: _question.choice[2].other,
                                image: _question.choice[2].eng,
                                cardState: cardStateCheck(2))),
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
                  onPressed: () async {
                    if (_selectCardIndex == -1) {
                      return;
                    }
                    _confettiController.stop();
                    setState(() {
                      _selectCardIndex = -1;
                    });
                    if (widget._currentGame == "2") {
                      context.go(
                          '/game/${widget._level}/${widget._stage}/${(int.parse(widget._currentGame) + 1).toString()}/word');
                    } else {
                      context.go(
                          '/game/${widget._level}/${widget._stage}/${(int.parse(widget._currentGame) + 1).toString()}/picture');
                    }

                    reloadQuestion();
                  },
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
