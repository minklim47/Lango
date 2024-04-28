import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/input.dart';
import 'package:lango_application/widgets/navigator.dart';
import "package:lango_application/widgets/wrapper.dart";

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/changepass"),
      body: Wrapper(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 45),
              child: Row(children: [Text("Change Password")])
            ),
            Expanded(
              child: ListView(
                children: const [
                  Form(
                    child: Column(
                      children: [
                        InputField(
                          icon: Icon(Icons.key),
                          placeholder: "Old Password",
                          pb: 20,
                        ),
                        InputField(
                          icon: Icon(Icons.key),
                          placeholder: "New Password",
                          pb: 20,
                        ),
                        InputField(
                          icon: Icon(Icons.key),
                          placeholder: "Confirm Password",
                          pb: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Add some extra space at the end
                ],
              ),
            ),
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
