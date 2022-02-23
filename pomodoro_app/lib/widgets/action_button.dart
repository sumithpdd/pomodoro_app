import 'package:flutter/material.dart';

import '../helpers/app_constants.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const ActionButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            child: Text(title, style: const TextStyle(fontSize: 12)),
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryLabelColor),
                backgroundColor:
                    MaterialStateProperty.all<Color>(kbuttonBackgoundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                            color: kbuttonBorderBackgoundColor)))),
            onPressed: onPressed));
  }
}
