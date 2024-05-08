import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/widgets/stage_card.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';

const currentStage = 9;
const totalStage = 12;

class WelComePage extends StatefulWidget {
  const WelComePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  // late User? _currentUser;
  late String _username = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        // _currentUser = user;
        _username = userData['username'];
      });
    } else {
      setState(() {
        // _currentUser = null;
      });
    }
  }

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
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Welcome, $_username',
                                  style: const TextStyle(fontSize: 20),
                                )),
                            const Text(
                              "สวัสดีครับ",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 50,
                          width: 50,
                          color: Colors.white,
                          child: Image.asset("assets/icons/avatar_spain.png"),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_left,
                            size: 40,
                          ),
                          Spacer(),
                          Text(
                            "Level 1",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_right, size: 40),
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
                                isLock: index > currentStage,
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
