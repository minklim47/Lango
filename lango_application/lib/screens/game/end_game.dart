import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/wrapper.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Image(
          image: AssetImage('assets/logos/get-start/lango_logo-v2.png'),
          width: 400,
          height: 400,
        ),
        Text("Good Job", style: Theme.of(context).textTheme.headlineLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 160,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Accuracy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "100",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ]),
            ),
            Container(
              width: 120,
              height: 160,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total XP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "100",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
        Expanded(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container()]))),
        if (MediaQuery.of(context).size.height > 500)
          SizedBox(height: MediaQuery.of(context).size.height / 10),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.yellow,
                  ),
                ),
                child: const Text("CONTINUE"),
              ),
            ))
      ])),
    );
  }
}
