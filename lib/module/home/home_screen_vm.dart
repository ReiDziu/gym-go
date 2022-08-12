import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/constant/routes.dart';
import 'package:gym_go/db/database_service.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/model/Goal.dart';
import 'package:gym_go/model/UserProfile.dart';
import 'package:gym_go/service/navigation/navigation_service.dart';
import 'package:gym_go/ui/screens/first_run/first_run_view_model.dart';

class HomeScreenViewModel with ChangeNotifier {
  HomeScreenViewModel({
    required this.navigationService,
  });

  final NavigationService navigationService;
  final UserProfile user = RAMDB.appInstance.user!;

  final List<Exercise> exercises = RAMDB.appInstance.exercises;

  late List<Goal> selectedBodyParts;

  void selectBodyPart(Goal part) {
    selectedBodyParts.add(part);
    notifyListeners();
  }

  void removeBodyPart(Goal part) {
    selectedBodyParts.remove(part);
    notifyListeners();
  }

  Goal get selectedGoal => user.selectedGoal!;

  set selectedGoal(Goal goal) {
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

  int get weight => user.weight!;

  set weight(int value) {
    user.weight = value;
    notifyListeners();
  }

  double get caloriesGoal =>
      ((user.age! < 40 ? 2000 : 1600) + (user.sex == Sex.FEMALE ? 0 : 400) + (user.selectedLevel! * 100)) *
      (user.selectedGoal?.title == FirstRunViewModel.goals[0].title ? 0.85 : 1.0) *
      (user.selectedGoal?.title == FirstRunViewModel.goals[2].title ? 1.2 : 1.0) *
      (user.selectedGoal?.title == FirstRunViewModel.goals[3].title ? 1.1 : 1.0);

  double get drinkGoal => user.weight! * 40.0;

  // ValueCallback<void> nextPageAction;
  late ValueCallback<String> snackAction;

  void nextPageAction(int currentPage, VoidCallback callback, BuildContext context) {
    RAMDB.appInstance.user = user;
    currentPage == 4 ? Navigator.pushReplacementNamed(context, HOME_SCREEN) : callback();
  }
}
