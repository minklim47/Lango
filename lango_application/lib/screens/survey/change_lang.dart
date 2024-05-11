import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/widgets/survey/lang_card.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class ChangelangPage extends StatelessWidget {
  const ChangelangPage({super.key});

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
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false)
                            .changeLanguage("th");
                        GoRouter.of(context).go('/');
                      },
                      child: const LangBox(title: "Thai", image: "th"),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<AppProvider>(context, listen: false)
                            .changeLanguage("es");
                        GoRouter.of(context).go('/');
                      },
                      child: const LangBox(title: 'Spanish', image: "es"),
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
