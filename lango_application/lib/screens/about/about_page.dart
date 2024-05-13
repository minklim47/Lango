import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20),
                child: Row(
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lango is a language learning app that helps users learn new languages through games and quizzes. Our app is designed to be user-friendly and interactive, making it easy for users to learn new languages in a fun and engaging way. With Lango, you can learn new languages at your own pace and on your own time. Whether you're a beginner or an advanced learner, Lango has something for everyone. Download our app today and start learning a new language with Lango!",
                      textAlign: TextAlign.justify,
                    ),
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
                          child: const Text("Support us"),
                        ),
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
                          child: const Text("Survey"),
                        ),
                        backgroundColor: AppColors.cream,
                        collapsedBackgroundColor: AppColors.cream,
                        children: [
                          // ListTile(title: Text("insert survey here")),
                          Consumer<AppProvider>(builder: (context, value, _) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                onPressed: () {
                                        
                              
                                  if (value.selectedReason == "") {
                                    print(value.selectedReason);
                                    GoRouter.of(context).go('/learn');
                                  } else if (value.languageLevel == "") {
                                    GoRouter.of(context).go('/level');
                                  } else {
                                    null;
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    value.selectedReason != "" &&
                                            value.languageLevel != ""
                                        ? Colors.grey
                                        : AppColors.yellow,
                                  ),
                                ),
                                child: value.languageLevel == "" ||
                                        value.languageLevel == ""
                                    ? Text("Enter Survey")
                                    : Text("Survey Completed"),
                              ),
                            );

                            // Text("Enter Survey"));
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
