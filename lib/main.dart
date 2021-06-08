import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/di.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/routes.dart';
import 'package:just_more_fitness/service/generation/db_generation.dart';
import 'package:just_more_fitness/ui/screens/exercise_details/ExerciseDetails.dart';
import 'package:just_more_fitness/ui/screens/first_run/first_run.dart';
import 'package:just_more_fitness/ui/screens/home/HomeScreen.dart';
import 'package:just_more_fitness/ui/screens/splash/SplashScreen.dart';

void main() async {
  InjectorManager.inject();

  // await CONSTANTS.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CONSTANTS.init();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: SplashScreen(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
        break;
      case FIRST_RUN:
        return MaterialPageRoute(
          builder: (context) => FirstRun(),
          settings: settings,
        );
        break;
      case HOME_SCREEN:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );
        break;
      case EXERCISE_DETAILS:
        return MaterialPageRoute(
          builder: (context) => ExerciseDetailsScreen(settings.arguments),
          settings: settings,
        );
        break;
      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
