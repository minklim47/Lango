import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/theme/custom_theme.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Row(children: [
                                Consumer<AppProvider>(
                                  builder: (context, value, _) {
                                    if (value.user != null) {
                                      return Expanded(
                                          child: Text(value.username ?? 'N/A',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineMedium,
                                              overflow: TextOverflow.ellipsis));
                                    } else {
                                      return const Text('User not logged in');
                                    }
                                  },
                                ),
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
                          Consumer<AppProvider>(
                            builder: (context, value, _) {
                              if (value.user != null) {
                                return Text(value.email ?? 'N/A',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    overflow: TextOverflow.ellipsis);
                              } else {
                                return const Text('User not logged in');
                              }
                            },
                          ),
                        ],
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
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("Do you want to sign out?",
                            style: Theme.of(context).textTheme.bodyMedium),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: AppColors.cream,
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                          TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Provider.of<AppProvider>(context, listen: false)
                                  .signOut();
                              GoRouter.of(context).go('/');
                            },
                            child: Text('Sign out',
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      );
                    });
              },
              style: CustomTheme.customTheme.outlinedButtonTheme.style,
              child: const Text("LOGOUT"),
            ))
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
