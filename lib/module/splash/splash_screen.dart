import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_go/constant/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    return const Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
