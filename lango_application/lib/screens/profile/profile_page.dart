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
  // ignore: library_private_types_in_public_api
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
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    Provider.of<AppProvider>(context).imageProfile),
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
        Consumer<AppProvider>(builder: (context, value, _) {
          final stagesCleared =
              value.currentStage + ((value.currentLevel - 1) * 12) -1;
          return Expanded(
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
                    children: <StatBox>[
                      StatBox(
                        title: 'Account Created Since',
                        value: value.createdAt,
                      ),
                      StatBox(
                        title: 'Current Language',
                        value: value.language == "es" ? "Español": "Thai",
                      ),
                      StatBox(
                        title: 'Experience Points',
                        value: value.exp.toString(),
                        foot: "xp",
                      ),
                      StatBox(
                        title: 'Stage cleared',
                        value: stagesCleared.toString(),
                        foot: "stages",
                      ),
                    ],
                  )));
        }),
        const SizedBox(height: 20),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "See you soon!",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Are you sure you want to sign out?",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.cream,
                      actions: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                          color: Color(0xFF5F5F5F)),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () async {
                                  await FirebaseAuth.instance.signOut();
                                  // ignore: use_build_context_synchronously
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .signOut();
                                  // ignore: use_build_context_synchronously
                                  GoRouter.of(context).go('/');
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color(0xFFFEE440)),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  child: Text(
                                    'Sign out',
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
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
