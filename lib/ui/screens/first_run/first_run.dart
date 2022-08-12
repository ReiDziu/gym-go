import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gym_go/db/user_repo.dart';
import 'package:gym_go/model/UserProfile.dart';
import 'package:gym_go/service/generation/db_generation.dart';
import 'package:gym_go/ui/screens/first_run/components/level_chooser.dart';
import 'package:gym_go/ui/screens/first_run/components/slider_switch.dart';
import 'package:gym_go/ui/screens/first_run/first_run_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstRun extends StatefulWidget {
  const FirstRun({
    required this.viewModel,
    super.key,
  });

  final FirstRunViewModel viewModel; // = Injector.appInstance.get<FirstRunViewModel>();

  @override
  _FirstRunState createState() => _FirstRunState();
}

class _FirstRunState extends State<FirstRun> {
  final int pagesCount = 5;
  final double heightOfBottomView = 106;
  int currentPage = 0;
  bool frameLoading = true;
  late PageController _controller;

  FirstRunViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();

    _controller = PageController(
      initialPage: currentPage,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      viewModel.user = UserRepo.getUser(prefs)..selectedGoal = CONSTANTS.allGoals[0];
      setState(() => frameLoading = false);
    });
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
      builder: (context) {
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

    return frameLoading
        ? const Material(child: Center(child: CircularProgressIndicator()))
        : Container(
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
                    child: const Text('511FITNESS'), // LogsExportPixellotlogo(),
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
                  child: Consumer<FirstRunViewModel>(
                    builder: (_, viewModel, __) {
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
                                              key: const ValueKey('SexToggle'),
                                              onTap: () => viewModel.changeSex(),
                                              enabled: viewModel.sex == Sex.FEMALE,
                                            ),
                                          ),
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
                                          child: const Text(
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
                    },
                  ),
                ),
              ),
            ),
          );
  }
}

class WizardLayout extends StatelessWidget {
  const WizardLayout({
    required this.pageTitle,
    required this.content,
    super.key,
  });

  final String pageTitle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    required this.pagesCount,
    required this.controller,
    required this.onPrevButtonTap,
    required this.onNextButtonTap,
    super.key,
  });

  final int pagesCount;
  final PageController controller;
  final VoidCallback onPrevButtonTap;
  final VoidCallback onNextButtonTap;

  Color getIconColor({required bool isRightButtonDisabled}) {
    return isRightButtonDisabled ? const Color.fromRGBO(202, 202, 202, 1) : const Color.fromRGBO(0, 154, 199, 1);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedPageIndex = (controller.hasClients && controller.page != null) ? controller.page!.round() : 0;

    final bool isLeftButtonDisabled = selectedPageIndex == 0;
    final bool isRightButtonDisabled = selectedPageIndex == pagesCount - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 52,
            ),
            onPressed: isLeftButtonDisabled ? null : onPrevButtonTap,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: IconButton(
            icon: const Icon(
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
