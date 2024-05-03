import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/wrapper.dart';
//import 'package:lango_application/theme/color_theme.dart';
//import 'package:lango_application/widgets/progress_bar.dart';

class ChooselangPage extends StatelessWidget {
  const ChooselangPage({Key? key}) : super(key: key);

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
                  childAspectRatio: 4,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/learn'),
                      child: LangBox(title: 'Thai'),
                    ),
                    GestureDetector(
                      onTap: () => GoRouter.of(context).go('/learn'),
                      child: LangBox(title: 'Spanish'),
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

class LangBox extends StatelessWidget {
  final String title;

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
