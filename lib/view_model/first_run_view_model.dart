import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/db/DatabaseService.dart';
import 'package:just_more_fitness/model/Goal.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/routes.dart';
import 'package:just_more_fitness/service/navigation/navigation_service.dart';

class FirstRunViewModel with ChangeNotifier {
  FirstRunViewModel({
    this.navigationService,
  });

  final NavigationService navigationService;
  UserProfile user = RAMDB.appInstance.user..selectedGoal = goals[0];

  get sex => user.sex;

  void changeSex() {
    user.sex = sex == Sex.MALE ? Sex.FEMALE : Sex.MALE;
    print(sex);
    notifyListeners();
  }

  static final List<Goal> goals = [
    Goal(title: 'Скинути вагу'),
    Goal(title: 'Покращити фігуру'),
    Goal(title: 'Набрати масу'),
    Goal(title: "Накачати м'язи"),
  ];

  static final List<Goal> bodyParts = [
    Goal(title: "М'язи рук"),
    Goal(title: "М'язи ніг"),
    Goal(title: "М'язи пресу"),
    Goal(title: "М'язи спини"),
  ];

  List<Goal> selectedBodyParts = [];

  void selectBodyPart(Goal part) {
    selectedBodyParts.add(part);
    notifyListeners();
  }

  void removeBodyPart(Goal part) {
    selectedBodyParts.remove(part);
    notifyListeners();
  }

  Goal get selectedGoal => user.selectedGoal;

  set selectedGoal(Goal goal) {
    user.selectedGoal = goal;
    notifyListeners();
  }

  int get selectedLevel => user.selectedLevel;

  set selectedLevel(int level) {
    user.selectedLevel = level;
    notifyListeners();
  }

  int get age => user.age;

  set age(int value) {
    user.age = value;
    notifyListeners();
  }

  int get height => user.height;

  set height(int value) {
    user.height = value;
    notifyListeners();
  }

  int get weight => user.weight;

  set weight(int value) {
    user.weight = value;
    notifyListeners();
  }

  // ValueCallback<void> nextPageAction;
  ValueCallback<String> snackAction;

  void nextPageAction(int currentPage, VoidCallback callback, BuildContext context) =>
      currentPage == 4 ? Navigator.pushReplacementNamed(context, HOME_SCREEN) : callback();
}
