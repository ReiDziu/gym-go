import 'package:injector/injector.dart';
import 'package:just_more_fitness/service/navigation/navigation_service.dart';
import 'package:just_more_fitness/view_model/HomeScreenViewModel.dart';
import 'package:just_more_fitness/view_model/first_run_view_model.dart';

class InjectorManager {
  static const String dnNoTokenShareRepository = "_dnNoTokenShareRepository";
  static const String startUpExecutor = "startUpExecutionProcess";

  static void inject() {
    Injector injector = Injector.appInstance;

    injector.registerSingleton<NavigationService>(() => NavigationService());

//     injector.registerDependency<SplashNotifier>(() {
//       final AuthenticationService authenticationService =
//       injector.get<AuthenticationService>();
//       final NavigationService navigationService =
//       injector.getDependency<NavigationService>();
//
// //      final StartNavigationSelector startNavigationSelector =
// //      injector.getDependency<StartNavigationSelector>();
//
//       return SplashNotifier(
//         authenticationService: authenticationService,
//         navigationService: navigationService,
//       );
//     });

    // injector.registerSingleton<SplashNotifier>(() {
    //   return Injector.appInstance.get<SplashNotifier>();
    // }, override: true, dependencyName: InjectorManager.startUpExecutor);

    injector.registerDependency<FirstRunViewModel>(() {
      final NavigationService navigationService = injector.get<NavigationService>();

      return FirstRunViewModel(
        navigationService: navigationService,
      );
    });

    injector.registerDependency<HomeScreenViewModel>(() {
      final NavigationService navigationService = injector.get<NavigationService>();

      return HomeScreenViewModel(
        navigationService: navigationService,
      );
    });
  }
}
