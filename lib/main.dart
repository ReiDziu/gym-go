import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/constant/routes.dart';
import 'package:gym_go/di.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/module/home/home_screen.dart';
import 'package:gym_go/module/splash/splash_screen.dart';
import 'package:gym_go/service/generation/db_generation.dart';
import 'package:gym_go/service/navigation/navigation_service.dart';
import 'package:gym_go/ui/screens/exercise_details/ExerciseDetails.dart';
import 'package:gym_go/ui/screens/first_run/first_run.dart';
import 'package:gym_go/ui/screens/first_run/first_run_view_model.dart';
import 'package:injector/injector.dart';

void main() {
  InjectorManager.inject();
  DBGENERATOR.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: const SplashScreen(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_SCREEN:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case FIRST_RUN:
        return MaterialPageRoute<dynamic>(
          builder: (context) => FirstRun(
            viewModel: FirstRunViewModel(
              navigationService: Injector.appInstance.get<NavigationService>(),
            ),
          ),
          settings: settings,
        );
      case HOME_SCREEN:
        return MaterialPageRoute<dynamic>(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      case EXERCISE_DETAILS:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ExerciseDetailsScreen(settings.arguments as Exercise),
          settings: settings,
        );
      default:
        assert(false, 'Need to implement ${settings.name}');
        return null;
    }
  }
}
