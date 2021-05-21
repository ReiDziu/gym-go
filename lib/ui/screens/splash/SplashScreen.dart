import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_more_fitness/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserAuth = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {

      await Future<int>.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed(isUserAuth ? HOME_SCREEN : FIRST_RUN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
