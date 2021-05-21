import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';

class LevelChooser extends StatelessWidget {
  const LevelChooser({
    this.levelsCount,
    this.selectedLevel,
    this.callback,
  });

  final int levelsCount;
  final int selectedLevel;
  final ValueCallback<int> callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        levelsCount,
        (index) {
          return IconButton(
            icon: Icon(
              index < selectedLevel ? Icons.run_circle : Icons.run_circle_outlined,
              size: 42,
            ),
            onPressed: () {
              callback(index);
            },
          );
        },
      ),
    );
  }
}
