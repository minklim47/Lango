import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/widgets/survey/learn_card.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class LearnforPage extends StatefulWidget {
  const LearnforPage({super.key});

  @override
  State<LearnforPage> createState() => _LearnforPageState();
}

class _LearnforPageState extends State<LearnforPage> {
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
                    current: 50,
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
                    "Why are you learning a language?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: GridView.count(
                    crossAxisCount:
                        MediaQuery.of(context).size.width < 330 ? 1 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1 / 1,
                    children: [
                      GestureDetector(
                        onTap: () => handleCardTap(0),
                        child: LearnBox(
                          title: 'Apply job',
                          image: 'job',
                          chooseState: _selectCardIndex == 0
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleCardTap(1),
                        child: LearnBox(
                          title: 'Travel',
                          image: 'travel',
                          chooseState: _selectCardIndex == 1
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleCardTap(2),
                        child: LearnBox(
                          title: 'Brain training',
                          image: 'brain',
                          chooseState: _selectCardIndex == 2
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleCardTap(3),
                        child: LearnBox(
                          title: 'School',
                          image: 'school',
                          chooseState: _selectCardIndex == 3
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleCardTap(4),
                        child: LearnBox(
                          title: 'Friend & Family',
                          image: 'friend',
                          chooseState: _selectCardIndex == 4
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => handleCardTap(5),
                        child: LearnBox(
                          title: 'Other',
                          image: 'other',
                          chooseState: _selectCardIndex == 5
                              ? ChooseState.click
                              : ChooseState.normal,
                        ),
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
                child: IgnorePointer(
                  ignoring: _selectCardIndex == -1,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectCardIndex != -1) {
                        final List<String> reasons = [
                          'Apply job',
                          'Travel',
                          'Brain training',
                          'School',
                          'Friend & Family',
                          'Other'
                        ];
                        Provider.of<AppProvider>(context, listen: false)
                            .surveyReason(reasons[_selectCardIndex]);

                        context.go("/level"); // Navigate to the next page
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please select a level before continuing.")));
                        if (kDebugMode) {
                          print("Please make a selection before continuing.");
                        }
                      }
                    },
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
                    context.go("/level"), // Navigate to the desired page
                child: const Text(
                  "SKIP",
                  style: TextStyle(
                    color: Colors
                        .grey, // Set text color to indicate it's clickable
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
