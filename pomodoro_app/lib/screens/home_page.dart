// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../helpers/app_constants.dart';
import '../widgets/action_button.dart';
import '../widgets/label_countdown_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LabelCountDownTimerController _labelClockController =
      LabelCountDownTimerController();

  var _durationInSecond = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _durationInSecond = 10 * 60;
  }

  @override
  Widget build(BuildContext context) {
    // Half Screen Dimensions
    final double height = MediaQuery.of(context).size.height / 4;
    final double width = MediaQuery.of(context).size.width / 4;

    LabelCountdownTimer labelClock = LabelCountdownTimer(
      controller: _labelClockController,
      duration: _durationInSecond,
      autoStart: false,
      isReverse: true,
      textStyle: kBigLableTextStyle,
      onComplete: () {},
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
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
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
                            _labelClockController.start();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Pause",
                          onPressed: () {
                            _labelClockController.pause();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Resume",
                          onPressed: () {
                            _labelClockController.resume();
                          }),
                      SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                          title: "Restart",
                          onPressed: () {
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
}
