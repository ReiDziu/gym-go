import 'package:just_more_fitness/model/Goal.dart';
import 'package:just_more_fitness/service/generation/db_generation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Sex {
  MALE,
  FEMALE,
}

class UserProfile {
  static SharedPreferences prefs;

  static init(SharedPreferences preferences) {
    prefs = preferences;
  }

  Sex get sex => prefs.getBool('genderMale') ?? true ? Sex.MALE : Sex.FEMALE;

  set sex(Sex sex) {
    prefs.setBool('genderMale', sex == Sex.MALE);
  }

  String get selectedGoal => prefs?.getString('selectedGoal') ?? CONSTANTS.allGoals[0];

  set selectedGoal(String goal) {
    prefs?.setString('selectedGoal', goal);
  }

  int get selectedLevel => prefs.getInt('level') ?? 0;

  set selectedLevel(int level) {
    prefs.setInt('level', level);
  }

  List<String> get selectedBodyParts => prefs.getStringList('selectedBodyParts');

  set selectedBodyParts(List<String> selectedBodyParts) {
    prefs.setStringList('selectedBodyParts', selectedBodyParts);
  }

  int get age => prefs.getInt('age') ?? 25;

  set age(int age) {
    prefs?.setInt('age', age);
  }

  int get height => prefs.getInt('height') ?? 180;

  set height(int height) {
    prefs.setInt('height', height);
  }

  int get weight => prefs.getInt('weight') ?? 75;

  set weight(int weight) {
    prefs.setInt('weight', weight);
  }

  double get drinkedWater => prefs.getDouble('drinkedWater') ?? 0;

  set drinkedWater(double drinkedWater) {
    prefs.setDouble('drinkedWater', drinkedWater);
  }

  double get burnedCalories => prefs.getDouble('burnedCalories') ?? 0;

  set burnedCalories(double burnedCalories) {
    prefs.setDouble('burnedCalories', burnedCalories);
  }
}
