import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_more_fitness/model/Exercise.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  ExerciseDetailsScreen(
    this.exercise,
    // this.callback,
  );

  final Exercise exercise;

  // final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 8.0,
              height: 80.0,
              // color: isSelected ? Colors.green : Colors.transparent,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              exercise.gifPath,
              height: 300.0,
              width: 300.0,
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      exercise.title,
                      style: TextStyle(
                        fontSize: 28,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тривалість підходу',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.time} секунд',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Кількість підходів',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.count} підходи',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тривалість перерви',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.rest} хвилини',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Кількість виконань',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.amount} рази на день',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    ExerciseView(exercise: exercise),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseView extends StatefulWidget {
  ExerciseView({@required this.exercise});

  final Exercise exercise;

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  Exercise get exercise => widget.exercise;

  Timer _timer;

  DateTime buyTime = DateTime.now(); //.add(Duration(milliseconds: 1));

  Duration get z => buyTime.add(widget.exercise.duration).difference(DateTime.now());

  String get exerciseTimer => DateTimeUtils.convertTimerTime(z);

  bool get isActive => _timer?.isActive ?? false;

  void startExercise() async {
    buyTime = DateTime.now();
    z.isNegative ? stopRefreshPage() : _timer = Timer.periodic(Duration(seconds: 1), (_) => setState(() {}));
  }

  void stopExercise() async {
    stopRefreshPage();
    setState(() => buyTime = DateTime.now());
  }

  void stopRefreshPage() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stopRefreshPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(8.0),
      // padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        // color: Colors.grey[850],
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black45,
        //     blurRadius: 2.0,
        //   ),
        // ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              children: [
                if (!z.isNegative)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        '${exerciseTimer}',
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ),
                RawMaterialButton(
                  onPressed: () {
                    isActive ? stopExercise() : startExercise();
                  },
                  fillColor: isActive ? Colors.red : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isActive ? 'Закінчити вправу' : 'Почати вправу',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 33.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
