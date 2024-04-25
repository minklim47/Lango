import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/routes/router.dart';
import 'package:lango_application/firebase_options.dart';
import 'package:lango_application/screens/LoginPage.dart';
import 'package:lango_application/screens/SignUpPage.dart';
import 'theme/custom_theme.dart';

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
          backgroundColor: const Color(0xFFFEF9EF),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFFEE440),
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
                          fontFamily: 'inter',
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(
                          color: Color(0xFFE8E8E8), width: 1.0),
                    ),
                  ),
                  child: const Text(
                    'ALREADY HAVE AN ACCOUNT',
                    style: TextStyle(
                        fontFamily: 'inter',
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

