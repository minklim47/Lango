import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/game/picture_card.dart';
import 'package:lango_application/widgets/game/word_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class PairMatchPage extends StatefulWidget {
  final String _level;
  final String _stage;
  final String _currentGame;
  const PairMatchPage(
      {super.key,
      required String level,
      required String stage,
      required String game})
      : _level = level,
        _stage = stage,
        _currentGame = game;

  @override
  State<PairMatchPage> createState() => _PairMatchPageState();
}

class _PairMatchPageState extends State<PairMatchPage> {
  late List<Word> _wordList;
  late List<String> _engWords;
  late List<String> _otherWords;
  late ConfettiController _confettiController;
  final List<int> _clear = [];
  double progress = 6;
  int _first = -1;
  int _second = -1;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));
    _wordList = [
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: "")
    ];
    _engWords = ["", "", "", "", ""];
    _otherWords = ["", "", "", "", ""];
    fetchWord();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void fetchWord() async {
    try {
      final gameProvider = Provider.of<GameProvider>(context, listen: false);
      await gameProvider.initData(widget._stage, widget._level);
      if (kDebugMode) {
        print("Current game");
        print(widget._currentGame);
      }
      setState(() {
        _wordList = gameProvider.matchingPair;
        _wordList.shuffle();
        for (int i = 0; i < 5; i++) {
          _otherWords[i] = _wordList[i].other;
        }
        _wordList.shuffle();
        for (int i = 0; i < 5; i++) {
          _engWords[i] = _wordList[i].eng;
        }
      });
      if (kDebugMode) {
        print("Word list");
        print(_wordList);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int findIndexByString(String word, String type) {
    for (int i = 0; i < _wordList.length; i++) {
      if ((type == "eng" && _wordList[i].eng == word) ||
          (type != "eng" && _wordList[i].other == word)) {
        return i;
      }
    }
    return -1;
  }

  CardState cardStateCheck(int index) {
    if (_clear.contains(index)) {
      return CardState.clear;
    }
    if (_first == index) {
      return CardState.correct;
    } else if (_second == index) {
      if (index.isOdd) {
        int value = findIndexByString(_otherWords[index ~/ 2], "other");
        if (_wordList[value].eng == _engWords[_first ~/ 2] && _first.isEven) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _clear.add(index);
              _clear.add(_first);
              _first = -1;
              _second = -1;
              if (_clear.length == 10) {
                _confettiController.play();
                Provider.of<GameProvider>(context, listen: false).addPoint(10);
                progress = 7;
              }
            });
          });
          return CardState.correct;
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _first = -1;
              _second = -1;
            });
          });
          return CardState.wrong;
        }
      } else {
        int value = findIndexByString(_engWords[index ~/ 2], "eng");
        if (_wordList[value].other == _otherWords[_first ~/ 2] && _first.isOdd) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _clear.add(index);
              _clear.add(_first);
              _first = -1;
              _second = -1;
              if (_clear.length == 10) {
                _confettiController.play();
                progress = 7;
              }
            });
          });
          return CardState.correct;
        } else {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _first = -1;
              _second = -1;
            });
          });
          return CardState.wrong;
        }
      }
    } else {
      return CardState.normal;
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
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ),
        Row(children: [
          Expanded(
              child: ProgressBar(
            max: 7,
            current: progress,
            height: 20,
          )),
          IconButton(
              onPressed: () async => {
                    Provider.of<GameProvider>(context, listen: false)
                        .resetScore(),
                    context.go("/")
                  },
              icon: const Icon(Icons.close)),
        ]),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
          child: Text(
            "Tap the matching Pairs",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (MediaQuery.of(context).size.height > 400)
          SizedBox(height: MediaQuery.of(context).size.height / 10),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3,
            children: List.generate(
              10,
              (index) => GestureDetector(
                  onTap: () {
                    if (_clear.contains(index)) {
                      return;
                    }
                    if (_first == -1) {
                      setState(() {
                        _first = index;
                      });
                    } else {
                      if (1 == 2) {
                        setState(() {
                          _second = index;
                        });
                      } else {
                        setState(() {
                          _second = index;
                        });
                      }
                    }
                  },
                  child: WordCard(
                    cardState: cardStateCheck(index),
                    word: index.isEven
                        ? _engWords[index ~/ 2]
                        : _otherWords[index ~/ 2],
                  )),
            ),
          ),
        ),
        if (MediaQuery.of(context).size.height > 500)
          SizedBox(height: MediaQuery.of(context).size.height / 10),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_clear.length < 10) {
                    return;
                  } else {
                    await Provider.of<GameProvider>(context, listen: false)
                        .completeStage(
                            int.parse(widget._level), int.parse(widget._stage));
                    context.go('/game/${widget._level}/${widget._stage}/0/end');
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    _clear.length < 10 ? Colors.grey : AppColors.yellow,
                  ),
                ),
                child: const Text("CONTINUE"),
              ),
            ))
      ])),
    );
  }
}
