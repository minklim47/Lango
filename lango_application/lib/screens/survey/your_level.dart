import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/survey/level_card.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/progress_bar.dart';

class YourlevelPage extends StatefulWidget {
  const YourlevelPage({super.key});

  @override
  State<YourlevelPage> createState() => _YourlevelPageState();
}

class _YourlevelPageState extends State<YourlevelPage> {
  int _selectCardIndex = -1;

  void handleCardTap(int index) {
    setState(() {
      _selectCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: ProgressBar(
                    max: 100,
                    current: 100,
                    height: 20,
                  ),
                ),
                IconButton(
                  onPressed: () => GoRouter.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What is your level?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                // Wrap the GridView in a Center widget
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width < 330 ? 1 : 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      childAspectRatio: 3,
                      children: [
                        GestureDetector(
                          onTap: () => handleCardTap(0),
                          child: LevelBox(
                            title: 'Beginner',
                            image: 'beginner',
                            langState: _selectCardIndex == 0
                                ? LangState.click
                                : LangState.normal,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => handleCardTap(1),
                          child: LevelBox(
                            title: 'Intermediate',
                            image: 'intermediate',
                            langState: _selectCardIndex == 1
                                ? LangState.click
                                : LangState.normal,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => handleCardTap(2),
                          child: LevelBox(
                            title: 'Expert',
                            image: 'expert',
                            langState: _selectCardIndex == 2
                                ? LangState.click
                                : LangState.normal,
                          ),
                        ),
                      ]),
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
                    onPressed: () => context.go("/level"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _selectCardIndex == -1 ? Colors.grey : AppColors.yellow,
                      ),
                    ),
                    child: const Text("CONTINUE"),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () =>
                    context.go("/level"),
                child: const Text(
                  "SKIP",
                  style: TextStyle(
                    color: Colors
                        .grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
