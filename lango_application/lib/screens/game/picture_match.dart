import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/game/picture_card.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:lango_application/widgets/wrapper.dart';

class PictureMatchPage extends StatelessWidget {
  const PictureMatchPage({super.key});

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
            "Which one of these is “แอปเปิ้ล”",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        MediaQuery.of(context).size.width < 375
            ? const Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PictureCard(
                          word: "apple",
                          image: "testimage",
                        ),
                        PictureCard(
                          word: "apple",
                          image: "testimage",
                        ),
                        PictureCard(
                          word: "apple",
                          image: "testimage",
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              PictureCard(
                                word: "apple",
                                image: "testimage",
                              ),
                              PictureCard(
                                word: "apple",
                                image: "testimage",
                              ),
                            ])),
                        PictureCard(
                          word: "apple",
                          image: "testimage",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go("/game/word"),
                child: const Text("SAVE CHANGES"),
              ),
            ))
      ])),
    );
  }
}
