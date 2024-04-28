import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:lango_application/theme/color_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: BottomNav(path: "/about"),
      body: Wrapper(
          child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20),
              child: Row(children: [
                Text("About Us"),
              ])),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Lango is a language learning app that helps users learn new languages through games and quizzes. Our app is designed to be user-friendly and interactive, making it easy for users to learn new languages in a fun and engaging way. With Lango, you can learn new languages at your own pace and on your own time. Whether you're a beginner or an advanced learner, Lango has something for everyone. Download our app today and start learning a new language with Lango!"),
                  SizedBox(height: 40),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 20),
                      child: Text("Support us")),
                  // Image.asset(
                  //   'assets/QRcode.png',
                  //   width: 200,
                  //   height: 200,
                  // ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
