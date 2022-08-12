import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/model/UserProfile.dart';

class RAMDB {
  static final RAMDB appInstance = RAMDB();

  UserProfile? user;

  List<Exercise> exercises = <Exercise>[];
}
