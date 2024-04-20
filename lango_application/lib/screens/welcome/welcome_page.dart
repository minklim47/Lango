import 'package:flutter/material.dart';
import 'package:lango_application/widgets/stage_card.dart';
import 'package:lango_application/widgets/navigator.dart';
import 'package:lango_application/widgets/wrapper.dart';

const currentStage = 9;
const totalStage = 12;

class WelComePage extends StatelessWidget {
  const WelComePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrapper(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Welcome, User",
                        style: TextStyle(fontSize: 20),
                      )),
                  Text(
                    "สวัสดีครับ",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              const Spacer(),
              Container(
                height: 20,
                width: 20,
                color: Colors.white,
                child: Image.asset("./"),
              )
            ],
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Icon(Icons.arrow_left, size: 40,),
                Spacer(),
                Text("Level 1", style: TextStyle(fontSize: 20),),
                Spacer(),
                Icon(Icons.arrow_right, size: 40),
              ],
            )),
        Expanded(
            child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
          childAspectRatio: 0.8,
          children: List.generate(
              totalStage,
              (index) => SizedBox(
                    child: StageCard(
                      stage: index,
                      isLock: index > currentStage,
                    ),
                  )),
        ))
      ])),
      bottomNavigationBar: const BottomNav(path: "/"),
    );
  }
}
