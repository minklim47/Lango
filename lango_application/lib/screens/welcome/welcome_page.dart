import 'package:firebase_auth/firebase_auth.dart';
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
  // ignore: library_private_types_in_public_api
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  // bool isFirstLoad = true;

  @override
  void initState() {
    super.initState(); // Changed to fetch level from provider
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
                          child: Image.asset(
                            Provider.of<AppProvider>(context).language == "es"
                                ? "assets/images/language/es_flag.png"
                                : "assets/images/language/th_flag.png",
                          ),
                        )
                      ],
                    ),
                  ),
                  const LevelControls(),
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
                                level: context.watch<AppProvider>().appLevel,
                                stage: index + 1,
                                isCurrent: context
                                            .watch<AppProvider>()
                                            .currentStage ==
                                        index + 1 &&
                                    context.watch<AppProvider>().currentLevel ==
                                        context.watch<AppProvider>().appLevel,
                                isLock: context
                                            .watch<AppProvider>()
                                            .currentLevel! <
                                        context.watch<AppProvider>().appLevel ||
                                    context
                                                .watch<AppProvider>()
                                                .currentLevel! <=
                                            context
                                                .watch<AppProvider>()
                                                .appLevel &&
                                        context
                                                .watch<AppProvider>()
                                                .currentStage! <
                                            index + 1,
                              ),
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
