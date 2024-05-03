import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/screens/about/about_page.dart';
import 'package:lango_application/screens/game/pair_match.dart';
import 'package:lango_application/screens/game/picture_match.dart';
import 'package:lango_application/screens/game/word_match.dart';
import 'package:lango_application/screens/profile/change_pass.dart';
import 'package:lango_application/screens/profile/edit_page.dart';
import 'package:lango_application/screens/profile/profile_page.dart';
//import 'package:lango_application/screens/survey/choose_lang.dart';
import 'package:lango_application/screens/welcome/welcome_page.dart';
import 'package:lango_application/screens/survey/learn_for.dart';
import 'package:lango_application/screens/survey/your_level.dart';

import '../screens/survey/choose_lang.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const ChooselangPage(),
      routes: <RouteBase>[
        GoRoute(
            path: "choose", builder: (context, state) => const ChooselangPage()),
        GoRoute(
            path: "level", builder: (context, state) => const YourlevelPage()),
        GoRoute(
            path: "learn", builder: (context, state) => const LearnforPage()),
        GoRoute(
            path: "about", builder: (context, state) => const AboutPage()),
        GoRoute(
            path: "profile", builder: (context, state) => const ProfilePage()),
        GoRoute(
            path: "select", builder: (context, state) => const Placeholder()),
        GoRoute(
            path: "reasons", builder: (context, state) => const Placeholder()),
        GoRoute(path: "edit", builder: (context, state) => const EditProfilePage()),
        GoRoute(path: "changepass", builder: (context, state) => const ChangePassPage()),
        GoRoute(
          path: "game",
          builder: (context, state) => const Placeholder(),
          routes: <RouteBase>[
            GoRoute(
              path: "picture",
              builder: (context, state) => const PictureMatchPage(),
            ),
            GoRoute(
              path: "word",
              builder: (context, state) => const WordMatchPage(),
            ),
            GoRoute(
              path: "pair",
              builder: (context, state) => const PairMatchPage(),
            ),
          ],
        )
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);
