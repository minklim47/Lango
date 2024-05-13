import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/screens/about/about_page.dart';
import 'package:lango_application/screens/auth/get_start_page.dart';
import 'package:lango_application/screens/auth/signin_page.dart';
import 'package:lango_application/screens/auth/signup_page.dart';
import 'package:lango_application/screens/game/game_page.dart';
import 'package:lango_application/screens/game/pair_match.dart';
import 'package:lango_application/screens/game/picture_match.dart';
import 'package:lango_application/screens/game/word_match.dart';
import 'package:lango_application/screens/profile/change_pass.dart';
import 'package:lango_application/screens/profile/edit_page.dart';
import 'package:lango_application/screens/profile/profile_page.dart';
import 'package:lango_application/screens/survey/change_lang.dart';
import 'package:lango_application/screens/welcome/welcome_page.dart';
import 'package:lango_application/screens/survey/learn_for.dart';
import 'package:lango_application/screens/survey/your_level.dart';
import 'package:provider/provider.dart';
import '../screens/survey/choose_lang.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const WelComePage(),
      routes: <RouteBase>[
        GoRoute(
            path: "getstart",
            builder: (context, state) => const GetStartPage()),
        GoRoute(
            path: "signin", builder: (context, state) => const SingInPage()),
        GoRoute(
            path: "signup", builder: (context, state) => const SignUpPage()),
        GoRoute(
            path: "choose",
            builder: (context, state) => const ChooselangPage()),
        GoRoute(
            path: "change",
            builder: ((context, state) => const ChangelangPage())),
        GoRoute(
            path: "level", builder: (context, state) => const YourlevelPage()),
        GoRoute(
            path: "learn", builder: (context, state) => const LearnforPage()),
        GoRoute(path: "about", builder: (context, state) => const AboutPage()),
        GoRoute(
            path: "profile", builder: (context, state) => const ProfilePage()),
        GoRoute(
            path: "select", builder: (context, state) => const Placeholder()),
        GoRoute(
            path: "reasons", builder: (context, state) => const Placeholder()),
        GoRoute(
            path: "edit", builder: (context, state) => const EditProfilePage()),
        GoRoute(
            path: "changepass",
            builder: (context, state) => const ChangePassPage()),
        GoRoute(
          path: "game/:level/:stage",
          builder: (context, state) {
            // Provide GameProvider above the GamePage and its nested routes
            return ChangeNotifierProvider(
              create: (context) => GameProvider(
                level: state.pathParameters['level']!,
                stage: state.pathParameters['stage']!,
              ),
              child: GamePage(
                level: state.pathParameters['level']!,
                stage: state.pathParameters['stage']!,
              ),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: "picture",
              builder: (context, state) => const PictureMatchPage(),
            ),
            GoRoute(
              path: "word",
              builder: (context, state) {
                Question? question = state.extra as Question;
                if (question == null) {
                  Error();
                }
                return WordMatchPage(question: question);
              },
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
