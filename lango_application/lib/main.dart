import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/routes/router.dart';
import 'package:lango_application/firebase_options.dart';
import 'package:lango_application/screens/LoginPage.dart';
import 'package:lango_application/screens/SignUpPage.dart';
import 'theme/custom_theme.dart';
import 'theme/color_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lango",
      theme: CustomTheme.customTheme,
      // routerConfig: router,
      home: Builder(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.cream,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome to Lango'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 60, color: AppColors.darkGrey)),
                const Image(
                  image: AssetImage('assets/logos/lango_logo.png'),
                  width: 450,
                  height: 450,
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                  ),
                  child: const SizedBox(
                    width: 255,
                    child: Text(
                      'GET STARTED',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.black,
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: AppColors.grey, width: 1.0),
                    ),
                  ),
                  child: const Text(
                    'ALREADY HAVE AN ACCOUNT',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
