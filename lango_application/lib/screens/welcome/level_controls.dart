import 'package:flutter/material.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:provider/provider.dart';

class LevelControls extends StatelessWidget {
  const LevelControls({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Opacity(
                opacity: appProvider.appLevel > 1 ? 1 : 0,
                child: IconButton(
                  onPressed: appProvider.decrementLevel,
                  icon: const Icon(Icons.arrow_left, size: 40),
                ),
              ),
              const Spacer(),
              Text(
                "Level ${appProvider.appLevel}",
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              Opacity(
                opacity: appProvider.appLevel < 3 ? 1 : 0,
                child: IconButton(
                  onPressed: appProvider.incrementLevel,
                  icon: const Icon(Icons.arrow_right, size: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
