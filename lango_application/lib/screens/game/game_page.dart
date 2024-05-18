import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  final String stage;
  final String level;
  const GamePage({super.key, required this.stage, required this.level});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Wrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Text(
              "Level ${widget.level}: Stage ${widget.stage}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Image.asset("assets/logos/lango_logo.png"),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        await Provider.of<GameProvider>(context, listen: false)
                            .initData(widget.stage, widget.level);
                      
                        var question =
                            // ignore: use_build_context_synchronously
                            Provider.of<GameProvider>(context, listen: false)
                                .questions[0];
                        if (kDebugMode) {
                          print(question.answerIndex);
                        }
                        // ignore: use_build_context_synchronously
                        context.go(
                            '/game/${widget.level}/${widget.stage}/0/picture');
                      },
                      child: const Text("Continue"))))
        ],
      ),
    ));
  }
}
