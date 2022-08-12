import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_go/model/Exercise.dart';
import 'package:gym_go/utility/date_time_utility.dart';

class ExerciseDetailsScreen extends StatelessWidget {
  const ExerciseDetailsScreen(
    this.exercise, {
    super.key,
  });

  final Exercise exercise;

  // final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      exercise.title,
                      style: const TextStyle(
                        fontSize: 28,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Тривалість підходу',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.time} хвилин',
                          style: const TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Кількість підходів',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.count} підходи',
                          style: const TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Тривалість перерви',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.rest} хвилини',
                          style: const TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Кількість виконань',
                          style: TextStyle(
                            fontSize: 16,
                            // color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '${exercise.amount} рази на день',
                          style: const TextStyle(
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
  const ExerciseView({
    required this.exercise,
    super.key,
  });

  final Exercise exercise;

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  Exercise get exercise => widget.exercise;

  Timer? _timer;

  DateTime buyTime = DateTime.now().add(const Duration(seconds: 1));

  Duration get z => buyTime.add(widget.exercise.duration).difference(DateTime.now());

  String get exerciseTimer => DateTimeUtility.convertTimerTime(z);

  bool get isActive => _timer?.isActive ?? false;

  Future<void> startExercise() async {
    buyTime = DateTime.now();
    z.isNegative
        ? stopExercise()
        : _timer = Timer.periodic(
            const Duration(seconds: 1),
            (_) => setState(() {
              if (z.isNegative) stopExercise();
            }),
          );
  }

  void stopExercise() {
    stopRefreshPage();
    setState(() => buyTime = DateTime.now().add(const Duration(seconds: 1)));
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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
          SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                if (!z.isNegative)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        exerciseTimer,
                        style: const TextStyle(
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
                      style: const TextStyle(
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
