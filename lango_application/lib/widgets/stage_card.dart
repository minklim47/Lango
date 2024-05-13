import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';

class StageCard extends StatelessWidget {
  final int level;
  final int stage;
  final bool isLock;

  const StageCard(
      {super.key,
      required this.level,
      required this.stage,
      this.isLock = false});

  @override
  Widget build(BuildContext context) {
    if (!isLock) {
      return GestureDetector(
          onTap: () => context.go("/game/$level/$stage"),
          child: Container(
              height: 65,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.blue,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0.0,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                        offset: Offset(0, 3))
                  ]),
              child: Center(
                  child: Text(
                stage.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))));
    } else {
      return GestureDetector(
          onTap: () =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("This level is not yet unlocked."),
              )),
          child: Container(
            height: 65,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.grey,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.0,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                      offset: Offset(0, 3))
                ]),
            child: const Center(
              child: Icon(
                Icons.lock,
                color: AppColors.darkGrey,
              ),
            ),
          ));
    }
  }
}
