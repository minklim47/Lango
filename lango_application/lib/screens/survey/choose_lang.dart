import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/survey/lang_card.dart';
import 'package:lango_application/widgets/wrapper.dart';

class ChooselangPage extends StatelessWidget {
  const ChooselangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "I want to learn...",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 40),
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
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/learn'),
<<<<<<< HEAD
                      child: const LangBox(title: 'Thai'),
                    ),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/learn'),
                      child: const LangBox(title: 'Spanish'),
=======
                      child: const LangBox(title: "Thai", image: "th"),
                    ),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/learn'),
                      child: const LangBox(title: 'Spanish',image: "es"),
>>>>>>> origin/Alpha
                    ),
                  ],
                ),
              ),
            ),
          ], 
        ),
      ),
    );
  }
}

<<<<<<< HEAD
class LangBox extends StatelessWidget {
  final String title;

  // ignore: use_key_in_widget_constructors
  const LangBox({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, // Use Colors.white instead of AppColors.white
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
=======
>>>>>>> origin/Alpha
