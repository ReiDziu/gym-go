import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:just_more_fitness/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future<int>.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed(
          prefs.getBool('userRegistered') ?? false ? HOME_SCREEN : FIRST_RUN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
