import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/widgets/game/word_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class PairMatchPage extends StatefulWidget {
  const PairMatchPage({super.key});

  @override
  State<PairMatchPage> createState() => _PairMatchPageState();
}

class _PairMatchPageState extends State<PairMatchPage> {
  late List<Word> wordList;

  @override
  void initState() {
    super.initState();
    wordList = [
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: ""),
      Word(eng: "", other: "")
    ];
  }

  void fetchWord() async {
    try {
      Provider.of<GameProvider>(context, listen: false);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Expanded(
              child: ProgressBar(
            max: 100,
            current: 10,
            height: 20,
          )),
          IconButton(
              onPressed: () => {context.go("/")},
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
              (index) => const WordCard(word: "Test"),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go("/game/pair"),
                child: const Text("SAVE CHANGES"),
              ),
            ))
      ])),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(home: PairMatchPage()));
// }
