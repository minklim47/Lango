import 'package:flutter/material.dart';
import 'package:lango_application/routes/router.dart';
import 'theme/custom_theme.dart';

void main() {
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