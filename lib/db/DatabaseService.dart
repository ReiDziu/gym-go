import 'package:just_more_fitness/model/Exercise.dart';
import 'package:just_more_fitness/model/UserProfile.dart';

class RAMDB {
  static final appInstance = RAMDB();

  UserProfile user;

  List<Exercise> exercises = [];
}
