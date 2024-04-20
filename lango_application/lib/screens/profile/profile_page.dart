import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
                backgroundImage: AssetImage('assets/avatar.png'),
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
                                const Expanded(
                                    child: Text(
                                  "Username",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis),
                                )),
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
                          const Text(
                            "useremail@gmail.com",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
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
        ElevatedButton(
            onPressed: () => context.go("/"), child: const Text("LOGOUT"))
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
