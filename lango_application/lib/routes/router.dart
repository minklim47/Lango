import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/screens/about/about_page.dart';
import 'package:lango_application/screens/auth/get_start_page.dart';
import 'package:lango_application/screens/auth/signin_page.dart';
import 'package:lango_application/screens/auth/signup_page.dart';
import 'package:lango_application/screens/game/pair_match.dart';
import 'package:lango_application/screens/game/picture_match.dart';
import 'package:lango_application/screens/game/word_match.dart';
import 'package:lango_application/screens/profile/change_pass.dart';
import 'package:lango_application/screens/profile/edit_page.dart';
import 'package:lango_application/screens/profile/profile_page.dart';
import 'package:lango_application/screens/welcome/welcome_page.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const GetStartPage(),
      routes: <RouteBase>[
        GoRoute(
            path: "auth/signin", builder: (context, state) => const SingInPage()),
        GoRoute(
            path: "auth/signup", builder: (context, state) => const SignUpPage()),
        GoRoute(
            path: "welcome", builder: (context, state) => const WelComePage()),
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
