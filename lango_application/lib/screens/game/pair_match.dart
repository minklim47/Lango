import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/game/word_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';

class PairMatchPage extends StatelessWidget {
  const PairMatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          IconButton(
              onPressed: () => {context.go("/")},
              icon: const Icon(Icons.close)),
          const Expanded(
              child: ProgressBar(
            max: 100,
            current: 10,
            height: 20,
          ))
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
              (index) => const WordCard(word: "Hello"),
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
