import 'package:flutter/material.dart';

class LevelControls extends StatelessWidget {
  final int level;
  final void Function() incrementLevel;
  final void Function() decrementLevel;

  const LevelControls({
    super.key,
    required this.level,
    required this.incrementLevel,
    required this.decrementLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: decrementLevel,
            icon: const Icon(Icons.arrow_left, size: 40),
          ),
          const Spacer(),
          Text(
            "Level $level",
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          IconButton(
            onPressed: incrementLevel,
            icon: const Icon(Icons.arrow_right, size: 40),
          ),
        ],
      ),
    );
  }
}
