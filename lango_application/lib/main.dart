import 'package:firebase_core/firebase_core.dart';
import 'package:lango_application/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/routes/router.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) =>
          AppProvider(), 
      child: MaterialApp.router(
        title: "Lango",
        theme: CustomTheme.customTheme,
        routerConfig: router,

        // routerDelegate: router.routerDelegate,
        // routeInformationParser: router.routeInformationParser,
      ),
    );
    // return MaterialApp.router(
    //  title: "Lango",
    //   theme: CustomTheme.customTheme,
    //   routerConfig: router,
    // );
  }
}
