import 'package:flutter/material.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/model/Goal.dart';

class ChooseGoal extends StatelessWidget {
  ///StatefulWidget {
  const ChooseGoal({
    required this.goals,
    required this.selectedGoal,
    required this.callback,
    super.key,
  });

  final List<Goal> goals;
  final Goal selectedGoal;
  final ValueCallback<Goal> callback;

  int get selectedIndex => goals.indexWhere((e) => e.title == selectedGoal.title);

//   @override
//   State<StatefulWidget> createState() => _ChooseGoalState();
// }
//
// class _ChooseGoalState extends State<ChooseGoal> {
//   List<Goal> get goals => widget.goals;
//
//   int get selectedIndex => widget.selectedIndex;
//
//   ValueCallback<int> get callback => widget.callback;
//
//   @override
//   void initState() {
//     super.initState();
//   }

  // Widget stackBehindDismiss() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     padding: const EdgeInsets.only(right: 20.0),
  //     color: Colors.red,
  //     child: const Icon(
  //       Icons.delete,
  //       color: Colors.white,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // controller: _scrollController,
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final Goal goal = goals[index];

        return _GoalCell(
          isSelected: selectedIndex == index,
          title: goal.title,
          selectAction: () {
            callback(goal);
          },
        );
      },
    );
  }
}

class _GoalCell extends StatelessWidget {
  const _GoalCell({
    required this.isSelected,
    required this.title,
    required this.selectAction,
  });

  final bool isSelected;
  final String title;
  final VoidCallback selectAction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: isSelected ? const Color.fromRGBO(235, 245, 242, 1) : const Color.fromRGBO(243, 243, 243, 1),
          child: InkWell(
            onTap: selectAction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 80.0,
                  color: isSelected ? Colors.green : Colors.transparent,
                ),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
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
        const Align(
          alignment: Alignment.bottomCenter,
        ),
      ],
    );
  }
}
