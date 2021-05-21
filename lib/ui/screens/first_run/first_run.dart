import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:injector/injector.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/ui/screens/first_run/components/ChooseBodyParts.dart';
import 'package:just_more_fitness/ui/screens/first_run/components/ChooseGoal.dart';
import 'package:just_more_fitness/ui/screens/first_run/components/SliderSwitch.dart';
import 'package:just_more_fitness/ui/screens/first_run/components/level_chooser.dart';
import 'package:just_more_fitness/view_model/first_run_view_model.dart';
import 'package:provider/provider.dart';

class FirstRun extends StatefulWidget {
  @override
  _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> {
  final int pagesCount = 5;
  final double heightOfBottomView = 106;
  int currentPage = 0;
  bool wifiGuide = false;
  PageController _controller;

  final FirstRunViewModel viewModel = Injector.appInstance.get<FirstRunViewModel>();

  FirstRunViewModel firstRunViewModel = FirstRunViewModel();

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
    );
  }

  void _pageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void _onPrevButtonTap() {
    _controller.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void _onNextButtonTap() {
    _controller.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void onLogoutButtonPressed() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('You will be returned to the home screen'),
          actions: <Widget>[
            RawMaterialButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RawMaterialButton(
              child: const Text('Log out'),
              onPressed: () {
                if (mounted) {}
              },
            ),
          ],
        );
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    // viewModel.nextPageAction = (_) {
    //   _onNextButtonTap();
    // };

    // viewModel.snackAction = (String text) {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
    // };

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFFFFFFF),
            Color.fromRGBO(232, 232, 232, 1),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Text('511FITNESS'), // LogsExportPixellotlogo(),
            ),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(Icons.logout),
            //     // icon: SvgPicture.asset('assets/images/logout.svg'),
            //     onPressed: onLogoutButtonPressed,
            //   ),
            // ],
          ),
          body: ChangeNotifierProvider<FirstRunViewModel>.value(
            value: viewModel,
            child: Consumer<FirstRunViewModel>(builder: (_, FirstRunViewModel viewModel, __) {
              return Column(
                children: <Widget>[
                  // Indicator(
                  //   pagesCount: pagesCount,
                  //   controller: _controller,
                  // ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        PageView(
                          controller: _controller,
                          onPageChanged: _pageChanged,
                          children: <Widget>[
                            WizardLayout(
                              pageTitle: 'ВКАЖІТЬ СТАТЬ',
                              content: Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.12,
                                    ),
                                    child: SliderSwitch(
                                      key: ValueKey('SexToggle'),
                                      onTap: () => viewModel.changeSex(),
                                      enabled: viewModel.sex == Sex.FEMALE,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            WizardLayout(
                              pageTitle: 'ОБЕРІТЬ ОСНОВНУ ЦІЛЬ',
                              content: SizedBox(
                                width: double.infinity,
                                child: ChooseGoal(
                                  goals: FirstRunViewModel.goals,
                                  selectedGoal: viewModel.selectedGoal,
                                  callback: (goal) => viewModel.selectedGoal = goal,
                                ),
                              ),
                            ),
                            WizardLayout(
                              pageTitle: 'ВКАЖІТЬ ВАШ РІВЕНЬ ПІДГОТОВКИ',
                              content: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: LevelChooser(
                                    levelsCount: 6,
                                    selectedLevel: viewModel.selectedLevel,
                                    callback: (index) {
                                      viewModel.selectedLevel = index + 1;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            WizardLayout(
                              pageTitle: "ОБЕРІТЬ ГРУПИ М'ЯЗІВ",
                              content: SizedBox(
                                width: double.infinity,
                                child: ChooseBodyParts(
                                  bodyParts: FirstRunViewModel.bodyParts,
                                  selectedBodyParts: viewModel.selectedBodyParts,
                                  selectAction: (part) => viewModel.selectBodyPart(part),
                                  unselectAction: (part) => viewModel.removeBodyPart(part),
                                ),
                              ),
                            ),
                            WizardLayout(
                              pageTitle: 'ВКАЖІТЬ СВОЇ ПАРАМЕТРИ',
                              content: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('ВІК'),
                                              RawMaterialButton(
                                                child: Text('${viewModel.age}',style: TextStyle(fontSize: 33),),
                                                onPressed: () => showMaterialNumberPicker(
                                                  context: context,
                                                  title: "Вкажіть свій вік",
                                                  maxNumber: 113,
                                                  minNumber: 13,
                                                  // step: 5,
                                                  confirmText: "Підтвердити",
                                                  cancelText: "Відмінити",
                                                  selectedNumber: viewModel.age,
                                                  onChanged: (value) => setState(() => viewModel.age = value),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('ЗРІСТ'),
                                              RawMaterialButton(
                                                child: Text('${viewModel.height}',style: TextStyle(fontSize: 33),),
                                                onPressed: () => showMaterialNumberPicker(
                                                  context: context,
                                                  title: "Вкажіть свій ріст",
                                                  maxNumber: 220,
                                                  minNumber: 140,
                                                  // step: 5,
                                                  confirmText: "Підтвердити",
                                                  cancelText: "Відмінити",
                                                  selectedNumber: viewModel.height,
                                                  onChanged: (value) => setState(() => viewModel.height = value),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('ВАГА'),
                                              RawMaterialButton(
                                                child: Text('${viewModel.weight}',style: TextStyle(fontSize: 33),),
                                                onPressed: () => showMaterialNumberPicker(
                                                  context: context,
                                                  title: "Вкажіть свою вагу",
                                                  maxNumber: 200,
                                                  minNumber: 40,
                                                  // step: 5,
                                                  confirmText: "Підтвердити",
                                                  cancelText: "Відмінити",
                                                  selectedNumber: viewModel.weight,
                                                  onChanged: (value) => setState(() => viewModel.weight = value),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: NavigationArrows(
                            pagesCount: pagesCount,
                            controller: _controller,
                            onPrevButtonTap: _onPrevButtonTap,
                            onNextButtonTap: _onNextButtonTap,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: heightOfBottomView,
                            decoration: const BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.18),
                                  blurRadius: 6,
                                )
                              ],
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  child: Text(
                                    'ДАЛІ',
                                  ),
                                  // style: ButtonStyle(
                                  //   backgroundColor: Colors.black,
                                  // ),
                                  // fillColor: Color.fromRGBO(0, 154, 199, 1),
                                  // color_0_154_199,
                                  //  borderRadius: const BorderRadius.all(
                                  //   Radius.circular(30.0),
                                  // ),
                                  onPressed: () {
                                    viewModel.nextPageAction(currentPage, _onNextButtonTap, context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class WizardLayout extends StatelessWidget {
  const WizardLayout({
    this.pageTitle,
    this.content,
  });

  final String pageTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 69,
            child: Center(
              child: Text(
                pageTitle,
                style: const TextStyle(
                  fontFamily: 'SFCompactTextSemiBold',
                  fontSize: 18,
                  color: Color(0xFF000000),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            //color: Colors.deepPurple,
            child: content,
          ),
        ),
      ],
    );
  }
}

class NavigationArrows extends StatelessWidget {
  const NavigationArrows({
    this.pagesCount,
    this.controller,
    this.onPrevButtonTap,
    this.onNextButtonTap,
  });

  final int pagesCount;
  final PageController controller;
  final VoidCallback onPrevButtonTap;
  final VoidCallback onNextButtonTap;

  Color getIconColor(bool isRightButtonDisabled) {
    return isRightButtonDisabled ? Color.fromRGBO(202, 202, 202, 1) : Color.fromRGBO(0, 154, 199, 1);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedPageIndex = (controller.hasClients && controller.page != null) ? controller.page.round() : 0;

    final bool isLeftButtonDisabled = selectedPageIndex == 0;
    final bool isRightButtonDisabled = selectedPageIndex == pagesCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 52,
            ),
            onPressed: isLeftButtonDisabled ? null : onPrevButtonTap,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: IconButton(
            icon: Icon(
              Icons.chevron_right,
              size: 52,
            ),
            onPressed: isRightButtonDisabled ? null : onNextButtonTap,
          ),
        ),
      ],
    );
  }
}
