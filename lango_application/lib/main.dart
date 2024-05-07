import 'package:firebase_core/firebase_core.dart';
import 'package:lango_application/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/routes/router.dart';
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
    return MaterialApp.router(
     title: "Lango",
      theme: CustomTheme.customTheme,
      routerConfig: router,
    );
  }
}
