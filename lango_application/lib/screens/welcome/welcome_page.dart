import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/stage_card.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

// const currentStage = 9;
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
    print("level");
    print(level);
  }

  void _decrementLevel() {
    if (level > 1) {
      setState(() {
        level--;
      });
    }
    print("level");
    print(level);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
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
                              String greeting = value.language == 'th'
                                  ? 'สวัสดีครับ'
                                  : 'Hola';
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
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                _decrementLevel();
                              },
                              icon: const Icon(Icons.arrow_left, size: 40)),
                          const Spacer(),
                          Text(
                            "Level $level",
                            style: const TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                _incrementLevel();
                              },
                              icon: const Icon(Icons.arrow_right, size: 40))
                        ],
                      )),
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
                                  stage: index + 1,
                                  isLock: context
                                              .watch<AppProvider>()
                                              .currentLevel! <
                                          level ||
                                      context
                                                  .watch<AppProvider>()
                                                  .currentLevel! <=
                                              level &&
                                          context
                                                  .watch<AppProvider>()
                                                  .currentStage! <
                                              index + 1),
                            )),
                  ))
                ])),
                bottomNavigationBar: const BottomNav(path: "/"),
              );
            }
          } else {
            return Container();
          }
        });
  }
}
