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
    prefs.setBool('userRegistered', true);
    prefs.setBool('genderMale', user.sex == Sex.MALE);
    prefs.setInt('level', user.selectedLevel);
    prefs.setInt('age', user.age);
    prefs.setInt('height', user.height);
    prefs.setInt('weight', user.weight);
  }
}
