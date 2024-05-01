import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:lango_application/screens/auth/signup_page.dart';
import 'package:lango_application/theme/color_theme.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Lango'.toUpperCase(),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 60, color: AppColors.darkGrey)),
            const Image(
              image: AssetImage('assets/logos/get-start/lango_logo-v2.png'),
              width: 450,
              height: 450,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                context.go("/auth/signup");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white,
                backgroundColor: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              ),
              child: const SizedBox(
                width: 255,
                child: Text(
                  'GET STARTED',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context.go("/auth/signin");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.black,
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: AppColors.grey, width: 1.0),
                ),
              ),
              child: const Text(
                'ALREADY HAVE AN ACCOUNT',
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
