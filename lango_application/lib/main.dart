import 'package:firebase_core/firebase_core.dart';
import 'package:lango_application/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/providers/game_provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameProvider(
            Provider.of<AppProvider>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: "Lango",
        theme: CustomTheme.customTheme,
        routerConfig: router,
      ),
    );
  }
}
