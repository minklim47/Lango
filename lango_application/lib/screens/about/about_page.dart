import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lango_application/providers/AppProvider.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/about"),
      body: Wrapper(
          child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20),
              child: Row(children: [
                Text("About Us"),
              ])),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Lango is a language learning app that helps users learn new languages through games and quizzes. Our app is designed to be user-friendly and interactive, making it easy for users to learn new languages in a fun and engaging way. With Lango, you can learn new languages at your own pace and on your own time. Whether you're a beginner or an advanced learner, Lango has something for everyone. Download our app today and start learning a new language with Lango!"),
                  const SizedBox(height: 30),
                  const Divider(
                    color: AppColors.grey,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10.0, 10),
                    child: ExpansionTile(
                      title: Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text("Support us")),
                      backgroundColor: AppColors.cream,
                      collapsedBackgroundColor: AppColors.cream,
                      children: [
                        ListTile(
                          title: Image.asset(
                            'assets/images/QRcode.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.grey,
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 10.0, 10),
                    child: ExpansionTile(
                      title: Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text("Survey")),
                      backgroundColor: AppColors.cream,
                      collapsedBackgroundColor: AppColors.cream,
                      children: [
                        // ListTile(title: Text("insert survey here")),
                        Consumer<AppProvider>(
                          builder: (context, data, child) {
                            return Column(
                              children: [
                                Text('Total Counter: ${data.counter}'),
                                ElevatedButton(
                                    onPressed: () {
                                      data.addCounter();
                                    },
                                    child: const Text('Increment Counter')),
                                    Text(data.currentUser?.email ?? "No user")
                                  
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
