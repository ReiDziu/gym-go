import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/constant/routes.dart';
import 'package:gym_go/db/database_service.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/model/UserProfile.dart';
import 'package:gym_go/service/generation/db_generation.dart';
import 'package:gym_go/service/navigation/navigation_service.dart';

class HomeScreenViewModel with ChangeNotifier {
  HomeScreenViewModel({
    required this.navigationService,
  });

  final NavigationService navigationService;
  final UserProfile user = RAMDB.appInstance.user!;

  final List<Exercise> exercises = RAMDB.appInstance.exercises;

  final List<String> selectedBodyParts = [];

  void selectBodyPart(String part) {
    selectedBodyParts.add(part);
    notifyListeners();
  }

  void removeBodyPart(String part) {
    selectedBodyParts.remove(part);
    notifyListeners();
  }

  String get selectedGoal => user.selectedGoal;

  set selectedGoal(String goal) {
    user.selectedGoal = goal;
    notifyListeners();
  }

  int get selectedLevel => user.selectedLevel!;

  set selectedLevel(int level) {
    user.selectedLevel = level;
    notifyListeners();
  }

  double get drinkedWater => user.drinkedWater;

  set drinkedWater(double level) {
    user.drinkedWater = level;
    notifyListeners();
  }

  double get burnedCalories => user.burnedCalories;

  set burnedCalories(double level) {
    user.burnedCalories = level;
    notifyListeners();
  }

  int get weight => user.weight;

  set weight(int value) {
    user.weight = value;
    notifyListeners();
  }

  double get caloriesGoal =>
      ((user.age < 40 ? 2000 : 1600) + (user.sex == Sex.FEMALE ? 0 : 400) + (user.selectedLevel * 100)) *
      (user.selectedGoal == CONSTANTS.allGoals[0] ? 0.85 : 1.0) *
      (user.selectedGoal == CONSTANTS.allGoals[2] ? 1.2 : 1.0) *
      (user.selectedGoal == CONSTANTS.allGoals[3] ? 1.1 : 1.0);

  double get drinkGoal => user.weight! * 40.0;

  // ValueCallback<void> nextPageAction;
  late ValueCallback<String> snackAction;

  void nextPageAction(int currentPage, VoidCallback callback, BuildContext context) {
    RAMDB.appInstance.user = user;
    currentPage == 4 ? Navigator.pushReplacementNamed(context, HOME_SCREEN) : callback();
  }
}
