// ignore_for_file: prefer_const_constructors

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import '../helpers/app_constants.dart';
import '../models/model.dart';
import '../models/user_data.dart';
import '../services/dbservice.dart';
import '../widgets/action_button.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/custom_button_bar.dart';
import '../widgets/label_countdown_timer.dart';
import 'settings_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CountDownController _clockController = CountDownController();
  final LabelCountDownTimerController _labelClockController =
      LabelCountDownTimerController();

  Appuser appuser = Appuser(); // Conditional flag

  var _durationInSecond = 0;

  DatabaseService databaseService = DatabaseService();
  List<PomodoroType> pomodoroData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseService.seedData();
    pomodoroData = databaseService.getAllPomodoroType().toList();
    appuser.selectedPomodoro = pomodoroData[1];
    _durationInSecond = appuser.selectedPomodoro!.timeInMinutes! * 60;
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Half Screen Dimensions
    final double height = MediaQuery.of(context).size.height / 4;
    final double width = MediaQuery.of(context).size.width / 4;

    void _timerCompleted() {
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: Text("Timer Completed"),
        content: Text("Time to break."),
      ).show(context);
      databaseService.saveUserRunHistory(appuser.selectedPomodoro!);
    }

    CountDownTimer _countDownTimer = CountDownTimer(
        duration: _durationInSecond,
        fillColor: Colors.tealAccent,
        onComplete: () => _timerCompleted());

    CircularCountDownTimer clock = CircularCountDownTimer(
      controller: _clockController,
      isReverseAnimation: true,
      ringColor: kBackgroundColor,
      height: height,
      width: width,
      strokeWidth: 25.0,
      autoStart: false,
      duration: _countDownTimer.duration,
      isReverse: true,
      textStyle: TextStyle(color: kSecondaryColor),
      fillColor: _countDownTimer.fillColor,
      backgroundColor: kbuttonBackgoundColor,
      strokeCap: StrokeCap.round,
      onComplete: _countDownTimer.onComplete,
    );

    LabelCountdownTimer labelClock = LabelCountdownTimer(
      controller: _labelClockController,
      duration: _countDownTimer.duration,
      autoStart: false,
      isReverse: true,
      textStyle: kBigLableTextStyle,
      onComplete: _countDownTimer.onComplete,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.headset_off),
        ),
        title: Text('Pomodoro'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              goToSettings(context);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButtonBar(
                  pomodoroData: pomodoroData,
                  callback: (pomodorotype) {
                    _setSelectedPomodoro(pomodorotype);
                  }),
            ),
            SizedBox(
              width: 10,
            ),
            Center(
              child: clock,
            ),
            SizedBox(
              width: 10,
            ),
            //bottom Panel
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: labelClock,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                          title: "Start",
                          onPressed: () {
                            _clockController.start();
                            _labelClockController.start();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Pause",
                          onPressed: () {
                            _clockController.pause();
                            _labelClockController.pause();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Resume",
                          onPressed: () {
                            _clockController.resume();
                            _labelClockController.resume();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Restart",
                          onPressed: () {
                            _clockController.restart(
                                duration: _durationInSecond);
                            _labelClockController.restart(
                                duration: _durationInSecond);
                          }),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _setSelectedPomodoro(PomodoroType pomodorotype) {
    appuser.selectedPomodoro = pomodorotype;
    setState(() {
      _durationInSecond = appuser.selectedPomodoro!.timeInMinutes! * 60;
      _clockController.restart(duration: _durationInSecond);
      _labelClockController.restart(duration: _durationInSecond);
    });
  }
}
