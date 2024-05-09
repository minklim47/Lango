import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/AppProvider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/theme/custom_theme.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // late User? _currentUser; 
  String _username = '';
  // String _email = '';

  @override
  void initState() {
    super.initState();
    // _currentUser = FirebaseAuth.instance.currentUser;
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
        // _email = userData['email'];
      });
    } else {
      setState(() {
        // _currentUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/profile"),
      body: Wrapper(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/icons/avatar_spain.png'),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Consumer<AppProvider>(
                        builder: (context, data, child) {
                          return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(_username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                          overflow: TextOverflow.ellipsis)),
                                  if (MediaQuery.of(context).size.width > 360)
                                    const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => context.go("/edit"),
                                    child: const Icon(
                                      Icons.edit,
                                      color: AppColors.darkGrey,
                                    ),
                                  )
                                ])),
                            Text(data.currentUser?.email ?? "No user",
                                style: Theme.of(context).textTheme.bodyLarge)
                          ],
                        );
                        },
                        
                      )))
            ],
          ),
        ),
        Expanded(
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 450, // Sets the maximum width to 500 pixels
                ),
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width < 330 ? 1 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 2,
                  children: const <StatBox>[
                    StatBox(
                      title: 'Account Created Since',
                      value: '2019',
                    ),
                    StatBox(
                      title: 'Longest Streaks',
                      value: '130',
                      foot: "days",
                    ),
                    StatBox(
                      title: 'Experience Points',
                      value: '6598',
                      foot: "xp",
                    ),
                    StatBox(
                      title: 'Language Learn',
                      value: '3',
                    ),
                  ],
                ))),
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: const Text("Do you want to sign out?"),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        context.go('/');
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {
                          // _currentUser = null;
                        });
                        // ignore: use_build_context_synchronously
                        context.go('/');
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                );
              },
            );
          },
          style: CustomTheme.customTheme.elevatedButtonTheme.style,
          child: const Text("LOGOUT"),
        )
      ])),
    );
  }
}

class StatBox extends StatelessWidget {
  final String title;
  final String value;
  final String? foot;

  const StatBox(
      {super.key, required this.title, required this.value, this.foot});

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
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          foot != null
              ? Text(
                  "$foot",
                  overflow: TextOverflow.ellipsis,
                )
              : const SizedBox(height: 16)
        ],
      ),
    );
  }
}
