import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:lango_application/survey/choose_lang.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/progress_bar.dart';

class YourlevelPage extends StatelessWidget {
  const YourlevelPage({super.key});

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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width < 330 ? 1 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 30,
                  childAspectRatio: 3,
                  children: const <LevelBox>[
                    LevelBox(
                      title: 'Beginner',
                    ),
                    LevelBox(
                      title: 'Intermediate',
                    ),
                    LevelBox(
                      title: 'Expert',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go("/"),
                  child: const Text("CONTINUE"),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => context.go("/"), // Navigate to the desired page
                child: const Text(
                  "SKIP",
                  style: TextStyle(
                    color: Colors.grey, // Set text color to indicate it's clickable
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

class LevelBox extends StatelessWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const LevelBox({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 11),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
