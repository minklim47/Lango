import 'package:flutter/material.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Wrapper(child: Text("About Page")),
      bottomNavigationBar: BottomNav(path: "/about"),
    );
  }
}