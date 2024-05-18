import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/game_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/widgets/wrapper.dart';
import 'package:provider/provider.dart';

class EndGamePage extends StatefulWidget {
  final String _level;
  final String _stage;
  final String _currentGame;

  const EndGamePage(
      {super.key,
      required String level,
      required String stage,
      required String game})
      : _level = level,
        _stage = stage,
        _currentGame = game;
  @override
  State<EndGamePage> createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  // void getScore(){

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Consumer<GameProvider>(builder: (context, value, _) {
          int requiredPoints = widget._stage == "12" ? 70 : 60;
          return Image(
            image: AssetImage(value.point >= requiredPoints
                ? 'assets/logos/get-start/lango_logo-v2.png'
                : 'assets/images/game/lose_endgame.png'),
            width: 400,
            height: 400,
          );
        }),
        Consumer<GameProvider>(builder: (context, value, _) {
          int requiredPoints = widget._stage == "12" ? 70 : 60;
          return Text(
              value.point >= requiredPoints ? "Good Job!" : "Try Again...",
              style: Theme.of(context).textTheme.headlineLarge);
        }),
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
                        child: Consumer<GameProvider>(
                          builder: (context, value, _) {
                            int requiredPoints =
                                widget._stage == "12" ? 70 : 60;

                            return Text(
                              '${(value.point / requiredPoints * 100).toInt()}%',
                              style: Theme.of(context).textTheme.headlineLarge,
                            );
                          },
                        )),
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
                        child: Consumer<GameProvider>(
                          builder: (context, value, _) {
                            return Text(
                              '${value.point * 10}',
                              style: Theme.of(context).textTheme.headlineLarge,
                            );
                          },
                        )),
                  ]),
            ),
          ],
        ),
        Expanded(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Container()]))),
        // if (MediaQuery.of(context).size.height > 500)
        //   SizedBox(height: MediaQuery.of(context).size.height / 10),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<GameProvider>(context, listen: false)
                      .resetScore();
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
