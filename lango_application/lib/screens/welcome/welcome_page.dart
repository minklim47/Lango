import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/screens/welcome/level_controls.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/stage_card.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

const totalStage = 12;

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  int level = 1;

  @override
  void initState() {
    super.initState();
  }

  void _incrementLevel() {
    if (level < 3) {
      setState(() {
        level++;
      });
    }
  }

  void _decrementLevel() {
    if (level > 1) {
      setState(() {
        level--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final user = appProvider.user;

    // return
    if (user == null) {
      GoRouter.of(context).go('/signin');
      return Container();
    } else {
      return Scaffold(
        body: Wrapper(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<AppProvider>(builder: (context, value, _) {
                      if (value.user != null) {
                        return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Welcome, ${value.username}',
                              style: const TextStyle(fontSize: 20),
                            ));
                      } else {
                        return Container();
                      }
                    }),
                    Consumer<AppProvider>(builder: (context, value, _) {
                      String greeting =
                          value.language == 'th' ? 'สวัสดี' : 'Hola';
                      return Text(
                        greeting,
                        style: const TextStyle(fontSize: 20),
                      );
                    }),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    context.go('/change');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    backgroundColor: AppColors.cream,
                  ),
                  child: Consumer<AppProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading) {
                        return const CircularProgressIndicator(); // Show loader while changing language
                      } else {
                        return Image.asset(
                          provider.language == "es"
                              ? "assets/images/language/es_flag.png"
                              : "assets/images/language/th_flag.png",
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          LevelControls(
              level: level,
              incrementLevel: _incrementLevel,
              decrementLevel: _decrementLevel),
          Expanded(
              child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            childAspectRatio: 0.8,
            children: List.generate(
                totalStage,
                (index) => SizedBox(
                      child: StageCard(
                        level: level,
                        stage: index + 1,
                        isLock: context.watch<AppProvider>().currentLevel! <
                                level ||
                            context.watch<AppProvider>().currentLevel! <=
                                    level &&
                                context.watch<AppProvider>().currentStage! <
                                    index + 1,
                        isCurrent: index + 1 ==
                                context.watch<AppProvider>().currentStage &&
                            level == context.watch<AppProvider>().currentLevel,
                      ),
                    )),
          ))
        ])),
        bottomNavigationBar: const BottomNav(path: "/"),
      );
    }
  }
}
