import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/model/Goal.dart';

class ChooseBodyParts extends StatelessWidget {
  ChooseBodyParts({
    this.bodyParts,
    this.selectedBodyParts,
    this.selectAction,
    this.unselectAction,
  });

  final List<Goal> bodyParts;
  final List<Goal> selectedBodyParts;
  final ValueCallback<Goal> selectAction;
  final ValueCallback<Goal> unselectAction;

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
      itemCount: bodyParts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final Goal part = bodyParts[index];

        return _BodyCell(
          isSelected: selectedBodyParts.contains(part),
          title: part.title,
          selectAction: () {
            selectAction(part);
          },
          unselectAction: () {
            unselectAction(part);
          },
        );
      },
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell({
    Key key,
    @required this.isSelected,
    @required this.title,
    @required this.selectAction,
    @required this.unselectAction,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final VoidCallback selectAction;
  final VoidCallback unselectAction;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        color: isSelected ? const Color.fromRGBO(235, 245, 242, 1) : Color.fromRGBO(243, 243, 243, 1),
        child: InkWell(
          onTap: isSelected ? unselectAction : selectAction,
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
