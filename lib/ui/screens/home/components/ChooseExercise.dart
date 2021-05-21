import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/model/Exercise.dart';

class ChooseExercise extends StatelessWidget {
  ChooseExercise({
    this.exercises,
    this.callback,
  });

  final List<Exercise> exercises;
  final ValueCallback<Exercise> callback;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // controller: _scrollController,
      itemCount: exercises?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final Exercise exercise = exercises[index];

        return _ExerciseCell(
          // isSelected: selectedIndex == index,
          title: exercise.title,
          selectAction: () {
            callback(exercise);
          },
        );
      },
    );
  }
}

class _ExerciseCell extends StatelessWidget {
  const _ExerciseCell({
    Key key,
    // @required this.isSelected,
    @required this.title,
    @required this.selectAction,
  }) : super(key: key);

  // final bool isSelected;
  final String title;
  final VoidCallback selectAction;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        // color: isSelected ? const Color.fromRGBO(235, 245, 242, 1) : Color.fromRGBO(243, 243, 243, 1),
        child: InkWell(
          onTap: selectAction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 8.0,
                height: 80.0,
                // color: isSelected ? Colors.green : Colors.transparent,
              ),
              const SizedBox(
                width: 10,
              ),
              // Image.asset(
              //   "assets/gif/ex1.gif",
              //   height: 125.0,
              //   width: 125.0,
              // ),
              // Image(
              //   image: AssetImage('assets/gif/ex1.gif'),
              // ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
      ),
    ]);
  }
}
