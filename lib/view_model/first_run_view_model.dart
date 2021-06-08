import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/db/DatabaseService.dart';
import 'package:just_more_fitness/db/UserRepo.dart';
import 'package:just_more_fitness/model/Goal.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/routes.dart';
import 'package:just_more_fitness/service/generation/db_generation.dart';
import 'package:just_more_fitness/service/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstRunViewModel with ChangeNotifier {
  FirstRunViewModel({
    this.navigationService,
  });

  final NavigationService navigationService;
  UserProfile user; //RAMDB.appInstance.user..selectedGoal = CONSTANTS.allGoals[0];

  get sex => user.sex;

  void changeSex() {
    user.sex = sex == Sex.MALE ? Sex.FEMALE : Sex.MALE;
    print(sex);
    notifyListeners();
  }

  List<String> selectedBodyParts = [];

  void selectBodyPart(String part) {
    selectedBodyParts.add(part);
    notifyListeners();
  }

  void removeBodyPart(String part) {
    selectedBodyParts.remove(part);
    notifyListeners();
  }

  String get selectedGoal => user?.selectedGoal;

  set selectedGoal(String goal) {
    user.selectedGoal = goal;
    notifyListeners();
  }

  int get selectedLevel => user?.selectedLevel;

  set selectedLevel(int level) {
    user.selectedLevel = level;
    notifyListeners();
  }

  int get age => user?.age;

  set age(int value) {
    user.age = value;
    notifyListeners();
  }

  int get height => user?.height;

  set height(int value) {
    user.height = value;
    notifyListeners();
  }

  int get weight => user?.weight;

  set weight(int value) {
    user.weight = value;
    notifyListeners();
  }

  // ValueCallback<void> nextPageAction;
  ValueCallback<String> snackAction;

  void nextPageAction(int page, VoidCallback callback, BuildContext context) => page == 4 ? _move(context) : callback();

  Future<void> _move(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserRepo.setUser(user, prefs);
    Navigator.pushReplacementNamed(context, HOME_SCREEN);
  }
}
