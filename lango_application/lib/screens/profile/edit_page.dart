import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/input.dart';
import 'package:lango_application/widgets/navigator.dart';
import "package:lango_application/widgets/wrapper.dart";

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/edit"),
      body: Wrapper(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                  onPressed: () => {context.go("/profile")},
                  icon: const Icon(Icons.arrow_back_ios),),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 45),
              child: Stack(
                alignment: const Alignment(2, 1.2),
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  Form(
                    child: Column(
                      children: [
                        InputField(
                          icon: Icon(Icons.face),
                          placeholder: "Username",
                          pb: 20,
                        ),
                        InputField(
                          icon: Icon(Icons.email),
                          placeholder: "Email",
                          pb: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Add some extra space at the end
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text("Change Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text("SAVE CHANGES"),
            ),
          ],
        ),
      ),
    );
  }
}
