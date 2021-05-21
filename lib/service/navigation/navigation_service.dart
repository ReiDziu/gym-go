import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> pushReplacementNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    return await navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    dynamic arguments,
    RoutePredicate predicate,
  }) async {
    return await navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<dynamic> pushNamed(
    String routeName, {
    dynamic arguments,
  }) async {
    return await navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void goBack() => navigatorKey.currentState.pop();
}
