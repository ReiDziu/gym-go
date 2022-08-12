import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/db/database_service.dart';
import 'package:gym_go/model/UserProfile.dart';
import 'package:gym_go/module/home/components/ChooseExercise.dart';
import 'package:gym_go/module/home/home_screen_vm.dart';
import 'package:gym_go/ui/screens/eat/EatProgram.dart';
import 'package:gym_go/ui/screens/exercise_details/ExerciseDetails.dart';
import 'package:gym_go/ui/screens/first_run/first_run_view_model.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;

  bool _isAppBarOpen = true;

  Future<void> _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  final UserProfile user = RAMDB.appInstance.user!;

  final HomeScreenViewModel viewModel = Injector.appInstance.get<HomeScreenViewModel>();

  @override
  void initState() {
    _getPrefs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymGo'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 10,
                left: width * 0.05,
                right: width * 0.05,
                bottom: 10,
              ),
              color: Colors.grey[800],
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Icon(
                        Icons.outlined_flag_rounded,
                        size: 38,
                        color: Colors.greenAccent,
                      ),
                      InkWell(
                        onTap: () {
                          showMaterialRadioPicker(
                            context: context,
                            title: 'Оберіть нову ціль',
                            confirmText: 'Підтвердити',
                            cancelText: 'Відмінити',
                            items: FirstRunViewModel.goals.map((e) => e.title).toList(),
                            // selectedValue: user?.selectedGoal?.title,
                            onChanged: (value) {
                              setState(
                                () {
                                  user.selectedGoal =
                                      FirstRunViewModel.goals.firstWhere((element) => element.title == value);
                                },
                              );
                            },
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Основна ціль'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 23,
                              ),
                            ),
                            Text(
                              user.selectedGoal!.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => showMaterialNumberPicker(
                          context: context,
                          title: 'Оберіть поточну вагу',
                          maxNumber: 200,
                          minNumber: 40,
                          confirmText: 'Підтвердити',
                          cancelText: 'Відмінити',
                          selectedNumber: viewModel.weight,
                          onChanged: (value) => setState(() => viewModel.weight = value),
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Вага'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.pink,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${user.weight}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.fitness_center_rounded,
                        size: 38,
                        color: Colors.orangeAccent,
                      ),
                      Text(
                        '${user.selectedLevel}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 38,
                        ),
                      ),
                    ],
                  ),
                  if (_isAppBarOpen)
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.local_drink_rounded,
                              size: 44,
                              color: Colors.lightBlue,
                            ),
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  LinearProgressIndicator(
                                    value: viewModel.drinkedWater / viewModel.drinkGoal,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                    backgroundColor: const Color(0x33000000),
                                    minHeight: 33,
                                  ),
                                  Center(
                                    child: Text(
                                      '${(viewModel.drinkedWater).toInt()} / ${(viewModel.drinkGoal).toInt()} мл',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.restaurant_rounded,
                              size: 44,
                              color: Colors.redAccent,
                            ),
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                  LinearProgressIndicator(
                                    value: viewModel.burnedCalories / viewModel.caloriesGoal,
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                                    backgroundColor: const Color(0x33000000),
                                    minHeight: 33,
                                  ),
                                  Center(
                                    child: Text(
                                      '${(viewModel.burnedCalories).toInt()} / ${(viewModel.caloriesGoal).toInt()} ккал',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        RawMaterialButton(
                          fillColor: Colors.amber,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (context) => const EatProgram(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Переглянути програму харчування'.toUpperCase()),
                          ),
                        ),
                      ],
                    ),
                  InkWell(
                    child: Icon(
                      _isAppBarOpen ? Icons.expand_less : Icons.expand_more,
                      size: 33,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        _isAppBarOpen = !_isAppBarOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ChooseExercise(
                exercises: viewModel.exercises,
                callback: (value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (context) => ExerciseDetailsScreen(value),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: HomeBottomNavigationBar(items: []),
      // body: _list[_page],
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.orangeAccent,
        icon: Icons.add,
        activeIcon: Icons.remove,
        elevation: 2.0,
        children: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.local_drink_rounded),
            label: 'Додати воду',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              _displayDialog(context, 'Введіть кількість випитої води', (value) {
                setState(() {
                  viewModel.drinkedWater += value;
                });
              });
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.restaurant_rounded),
            label: 'Додати калорії',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              _displayDialog(context, 'Введіть кількість калорій', (value) {
                setState(() {
                  viewModel.burnedCalories += value;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  Future<void> _displayDialog(BuildContext context, String title, ValueCallback<double> callback) async {
    final TextEditingController textFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: textFieldController,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.number,
            // decoration: InputDecoration(hintText: hint),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Відмінити'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Підтвердити'),
              onPressed: () {
                final double value = int.tryParse(textFieldController.text)?.toDouble() ?? 0;
                callback(value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
