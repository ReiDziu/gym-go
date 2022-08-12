// ignore_for_file: avoid_classes_with_only_static_members

import 'package:gym_go/model/UserProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo {
  static UserProfile getUser(SharedPreferences prefs) {
    if (prefs.getBool('userRegistered') ?? false) {
      return UserProfile()
        ..sex = prefs.getBool('genderMale') ?? true ? Sex.MALE : Sex.FEMALE
        ..selectedLevel = prefs.getInt('level') ?? 3
        ..age = prefs.getInt('age') ?? 23
        ..height = prefs.getInt('height') ?? 180
        ..weight = prefs.getInt('weight') ?? 66;
    } else {
      return UserProfile()
        ..sex = Sex.MALE
        ..selectedLevel = 0
        ..age = 25
        ..height = 180
        ..weight = 75;
    }
  }

  static void setUser(UserProfile user, SharedPreferences prefs) {
    prefs
      ..setBool('userRegistered', true)
      ..setBool('genderMale', user.sex == Sex.MALE)
      ..setInt('level', user.selectedLevel)
      ..setInt('age', user.age)
      ..setInt('height', user.height)
      ..setInt('weight', user.weight);
  }
}
