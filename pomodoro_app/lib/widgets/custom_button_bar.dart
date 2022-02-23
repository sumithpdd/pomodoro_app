import 'package:flutter/material.dart';
import '../helpers/app_constants.dart';
import '../models/model.dart';

class CustomButtonBar extends StatefulWidget {
  final List<PomodoroType> pomodoroData;
  final Function(PomodoroType) callback;
  const CustomButtonBar(
      {Key? key, required this.pomodoroData, required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomButtonBarState();
  }
}

class _CustomButtonBarState extends State<CustomButtonBar> {
  @override
  void initState() {
    super.initState();
  }

  final ButtonStyle _buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(kbuttonBackgoundColor),
    side: MaterialStateProperty.all<BorderSide>(
      const BorderSide(color: kbuttonBorderBackgoundColor, width: 1),
    ),
  );
  int selectedIndex = 0;
  List<Widget> _buildButtonsWithNames() {
    var buttonsList = <Widget>[];
    for (int index = 0; index < widget.pomodoroData.length; index++) {
      buttonsList.add(ElevatedButton(
          style: _buttonStyle,
          onPressed: () async {
            setState(() {
              selectedIndex = index;
            });
            widget.callback(widget.pomodoroData[index]);
          },
          child: Text(
            widget.pomodoroData[index].typeLabel!,
            style: selectedIndex == index
                ? kActionTextStyle
                : kDisabledActionTextStyle,
          )));
    }
    return buttonsList;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: _buildButtonsWithNames(),
    );
  }
}
