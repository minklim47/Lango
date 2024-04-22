import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/game/word_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';

class WordMatchPage extends StatelessWidget {
  const WordMatchPage({super.key});

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
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Text(
            "How do you say “small”",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const Expanded(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              WordCard(word: "Hello"),
              WordCard(word: "Hello"),
              WordCard(word: "Hello")
            ]))),
        if (MediaQuery.of(context).size.height > 500)
          SizedBox(height: MediaQuery.of(context).size.height / 10),
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
