import 'package:gym_go/model/Goal.dart';

enum Sex {
  MALE,
  FEMALE,
}

class UserProfile {
  Sex? sex;

  Goal? selectedGoal;

  int? selectedLevel;

  List<Goal> selectedBodyParts = <Goal>[];

  int? age;
  int? height;
  int? weight;

  double drinkedWater = 0;
  double burnedCalories = 0;
}
