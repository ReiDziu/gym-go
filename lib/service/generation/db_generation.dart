import 'package:just_more_fitness/db/DatabaseService.dart';
import 'package:just_more_fitness/model/Exercise.dart';
import 'package:just_more_fitness/model/UserProfile.dart';

class DBGENERATOR {
  static init() {
    RAMDB.appInstance.user = UserProfile()
      ..sex = Sex.MALE
      ..selectedLevel = 0
      ..age = 25
      ..height = 180
      ..weight = 75;

    RAMDB.appInstance.exercises.addAll(allExercises);
  }

  static final allExercises = <Exercise>[
    Exercise(
      title: 'Вправа 1',
      gifPath: 'assets/gif/ex1.gif',
      duration: Duration(minutes: 5),
      count: 4,
      interval: Duration(minutes: 2),
      amount: 2,
    ),
    Exercise(
      title: 'Вправа 2',
      gifPath: 'assets/gif/ex2.gif',
      duration: Duration(minutes: 10),
      count: 3,
      interval: Duration(minutes: 4),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 3',
      gifPath: 'assets/gif/ex3.gif',
      duration: Duration(minutes: 15),
      count: 6,
      interval: Duration(minutes: 3),
      amount: 4,
    ),
    Exercise(
      title: 'Вправа 4',
      gifPath: 'assets/gif/ex4.gif',
      duration: Duration(minutes: 10),
      count: 5,
      interval: Duration(minutes: 3),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 5',
      gifPath: 'assets/gif/ex5.gif',
      duration: Duration(minutes: 4),
      count: 4,
      interval: Duration(minutes: 2),
      amount: 2,
    ),
    Exercise(
      title: 'Вправа 6',
      gifPath: 'assets/gif/ex6.gif',
      duration: Duration(minutes: 15),
      count: 2,
      interval: Duration(minutes: 3),
      amount: 3,
    ),
    Exercise(
      title: 'Вправа 7',
      gifPath: 'assets/gif/ex7.gif',
      duration: Duration(minutes: 6),
      count: 2,
      interval: Duration(minutes: 4),
      amount: 2,
    ),
  ];
}
