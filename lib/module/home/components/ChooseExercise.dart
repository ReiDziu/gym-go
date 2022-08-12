import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/module/home/components/training_item.dart';

class ChooseExercise extends StatelessWidget {
  const ChooseExercise({
    required this.exercises,
    required this.callback,
    super.key,
  });

  final List<Exercise> exercises;
  final ValueCallback<Exercise> callback;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // controller: _scrollController,
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        // final Exercise exercise = exercises[index];

        return const Padding(
          padding: EdgeInsets.all(11.0),
          child: TrainingItem(
              // isSelected: selectedIndex == index,
              // title: exercise.title,
              // selectAction: () {
              //   callback(exercise);
              // },
              ),
        );
      },
    );
  }
}
