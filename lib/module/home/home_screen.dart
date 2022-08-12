import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gym_go/constant/colors.dart';
import 'package:gym_go/constant/constants.dart';
import 'package:gym_go/db/user_repo.dart';
import 'package:gym_go/model/UserProfile.dart';
import 'package:gym_go/module/home/components/ChooseExercise.dart';
import 'package:gym_go/module/home/home_screen_vm.dart';
import 'package:gym_go/ui/screens/exercise_details/ExerciseDetails.dart';
import 'package:injector/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;

  late UserProfile user; // = RAMDB.appInstance.user;

  final HomeScreenViewModel viewModel = Injector.appInstance.get<HomeScreenViewModel>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();

      user = UserRepo.getUser(prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Icon(
              Icons.fitness_center,
              size: 38,
              color: color_icon_primary,
            ),
            Text(
              'GymGo',
              style: TextStyle(
                color: color_text,
                fontSize: 38,
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('text'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('text'),
                    ),
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
      floatingActionButton: SpeedDial(
        // backgroundColor: Colors.blue[900],
        // foregroundColor: Colors.orangeAccent,
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
