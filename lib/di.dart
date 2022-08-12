// ignore_for_file: avoid_classes_with_only_static_members

import 'package:gym_go/module/home/home_screen_vm.dart';
import 'package:gym_go/service/navigation/navigation_service.dart';
import 'package:gym_go/ui/screens/first_run/first_run_view_model.dart';
import 'package:injector/injector.dart';

class InjectorManager {
  // static const String dnNoTokenShareRepository = '_dnNoTokenShareRepository';
  // static const String startUpExecutor = 'startUpExecutionProcess';

  static void inject() {
    final Injector injector = Injector.appInstance;

    injector
      ..registerSingleton<NavigationService>(() => NavigationService())

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

      ..registerDependency<FirstRunViewModel>(() {
        final NavigationService navigationService = injector.get<NavigationService>();

        return FirstRunViewModel(
          navigationService: navigationService,
        );
      })
      ..registerDependency<HomeScreenViewModel>(() {
        final NavigationService navigationService = injector.get<NavigationService>();

        return HomeScreenViewModel(
          navigationService: navigationService,
        );
      });
  }
}
