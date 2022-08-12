// ignore_for_file: avoid_classes_with_only_static_members

import 'package:gym_go/db/database_service.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/model/UserProfile.dart';

class DBGENERATOR {
  static void init() {
    RAMDB.appInstance.user = UserProfile()
      ..sex = Sex.MALE
      ..selectedLevel = 0
      ..age = 25
      ..height = 180
      ..weight = 75;

    RAMDB.appInstance.exercises.addAll(allExercises);
  }

  static final List<Exercise> allExercises = <Exercise>[
    Exercise(
      title: 'Вправа 1',
      gifPath: 'assets/gif/ex1.gif',
      duration: const Duration(minutes: 5),
      count: 4,
      interval: const Duration(minutes: 2),
      amount: 2,
    ),
    Exercise(
      title: 'Вправа 2',
      gifPath: 'assets/gif/ex2.gif',
      duration: const Duration(minutes: 10),
      count: 3,
      interval: const Duration(minutes: 4),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 3',
      gifPath: 'assets/gif/ex3.gif',
      duration: const Duration(minutes: 15),
      count: 6,
      interval: const Duration(minutes: 3),
      amount: 4,
    ),
    Exercise(
      title: 'Вправа 4',
      gifPath: 'assets/gif/ex4.gif',
      duration: const Duration(minutes: 10),
      count: 5,
      interval: const Duration(minutes: 3),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 5',
      gifPath: 'assets/gif/ex5.gif',
      duration: const Duration(minutes: 4),
      count: 4,
      interval: const Duration(minutes: 2),
      amount: 2,
    ),
    Exercise(
      title: 'Вправа 6',
      gifPath: 'assets/gif/ex6.gif',
      duration: const Duration(minutes: 15),
      count: 2,
      interval: const Duration(minutes: 3),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 7',
      gifPath: 'assets/gif/ex7.gif',
      duration: const Duration(minutes: 6),
      count: 2,
      interval: const Duration(minutes: 4),
      amount: 2,
    ),
  ];
}
