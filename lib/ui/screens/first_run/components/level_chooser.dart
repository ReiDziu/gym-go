import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';

class LevelChooser extends StatelessWidget {
  const LevelChooser({
    required this.levelsCount,
    required this.selectedLevel,
    required this.callback,
    super.key,
  });

  final int levelsCount;
  final int selectedLevel;
  final ValueCallback<int> callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
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
