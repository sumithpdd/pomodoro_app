// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pomodoro_app/data/data.dart';

import '../models/model.dart';
import '../widgets/action_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var pomodoroDataList = [];
  @override
  void initState() {
    _readSettings();
    super.initState();
  }

  _readSettings() {
    pomodoroDataList = pomodoroData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
            child:
                ActionButton(title: "Add New Pomodoro Type", onPressed: () {}),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: pomodoroDataList.length,
              itemBuilder: (BuildContext context, int index) {
                var pomodoroType = pomodoroDataList[index];
                return _listTile(pomodoroType);
              },
            ),
          ),
        ],
      ),
    );
  }

  _savePomodoro(
      PomodoroType pomodoroType, String savetypeLabel, int timeInMinutes) {
    // print("${pomodoroType.typeLabel} ${pomodoroType.timeInMinutes.toString()}");
  }

  Widget _listTile(PomodoroType pomodoroType) {
    var _textEditingController = TextEditingController();
    _textEditingController.text = pomodoroType.typeLabel!;
    String savetypeLabel = pomodoroType.typeLabel!;
    int timeInMinutes = pomodoroType.timeInMinutes!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 175,
              child: TextField(
                onChanged: (value) => {savetypeLabel = value},
                controller: _textEditingController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IncrementDecrement(
                  decreaseValue: (value) {
                    timeInMinutes = value;
                  },
                  startValue: pomodoroType.timeInMinutes!,
                  increaseValue: (value) {
                    timeInMinutes = value;
                  },
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () =>
                  _savePomodoro(pomodoroType, savetypeLabel, timeInMinutes),
            ),
          ],
        ),
      ),
    );
  }
}

class IncrementDecrement extends StatefulWidget {
  final int startValue;
  final Function decreaseValue;
  final Function increaseValue;
  const IncrementDecrement({
    Key? key,
    required this.startValue,
    required this.decreaseValue,
    required this.increaseValue,
  }) : super(key: key);

  @override
  _FacilitiesWidgetState createState() => _FacilitiesWidgetState();
}

class _FacilitiesWidgetState extends State<IncrementDecrement> {
  late int _value;

  @override
  void initState() {
    _value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _value--;
                  if (_value < 0) {
                    _value = 0;
                  }
                });
                widget.decreaseValue(_value);
              },
              icon: Icon(Icons.remove),
            ),
            Text(
              _value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _value++;
                });
                widget.increaseValue(_value);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
