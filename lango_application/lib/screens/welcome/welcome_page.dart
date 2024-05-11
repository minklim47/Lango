import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/widgets/stage_card.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

// const currentStage = 9;
const totalStage = 12;

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  // late User? _currentUser;
  // late String _username = '';
  // final AppProvider _appProvider = AppProvider();
  int level = 1;

  @override
  void initState() {
    super.initState();
    
    // _getCurrentUser();
    // Fetch the current user when the widget initializes
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
  // void _getCurrentUser() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     DocumentSnapshot userData = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();

  //     setState(() {
  //       _currentUser = user;
  //       _username = userData['username'];
  //     });
  //   } else {
  //     setState(() {
  //       _currentUser = null;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              // AlertDialog(
              //   title: const Text('Not Sign In'),
              //   content: const Text('You need to sign in to access this page.'),
              //   actions: [
              //     TextButton(
              //       onPressed: () {
              //         context.go('/signin');
              //       },
              //       child: const Text('Sign In'),
              //     )
              //   ],
              // );
              // context.go('/signin');
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
                        // Container(
                        //   height: 50,
                        //   width: 50,
                        //   color: Colors.white,
                        //   child: Image.asset("assets/icons/avatar_spain.png"),
                        // )
                        ElevatedButton(
                            onPressed: () {
                              context.go('/choose');
                            },
                            child: Image.asset("assets/icons/avatar_spain.png"),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                            ))
                      ],
                    ),
                  ),
                  // const Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 20),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           Icons.arrow_left,
                  //           size: 40,
                  //         ),
                  //         Spacer(),
                  //         Text(
                  //           "Level 1",
                  //           style: TextStyle(fontSize: 20),
                  //         ),
                  //         Spacer(),
                  //         Icon(Icons.arrow_right, size: 40),
                  //       ],
                  //     )),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
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
                  // Consumer(builder: builder)
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
