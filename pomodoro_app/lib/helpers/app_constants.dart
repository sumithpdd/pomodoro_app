import 'dart:io';

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF2A2B4D);
const kSecondaryColor = Color(0xFF2A2B4D);
const kShadowColor = Color.fromRGBO(72, 76, 82, 0.16);

const kBackgroundColor = Color(0xFFE7EEFB);
const kSidebarBackgroundColor = Color(0xFFF1F4FB);
const kCardPopupBackgroundColor = Color(0xFFF5F8FF);

const kPrimaryLabelColor = Color(0xFFF1F4FB);
const kSecondaryLabelColor = Color(0xB3FFFFFF);

const kbuttonBackgoundColor = Color(0xFF009688);
const kbuttonBorderBackgoundColor = Color.fromARGB(255, 39, 185, 171);

var kActionTextStyle = TextStyle(
  fontSize: 15.0,
  color: kPrimaryColor,
  fontWeight: FontWeight.w600,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);
var kDisabledActionTextStyle = TextStyle(
  fontSize: 15.0,
  color: kSecondaryLabelColor,
  fontWeight: FontWeight.w600,
  fontFamily: Platform.isIOS ? 'SF Pro Text' : null,
  decoration: TextDecoration.none,
);

var kBigLableTextStyle = const TextStyle(
  color: kSecondaryColor,
  fontSize: 55,
  fontWeight: FontWeight.bold,
);
// Text constants
const String kWorkLabel = 'Work';
const String kShortBreakLabel = 'Short break';
const String kLongBreakLabel = 'Long break';
const String k3minLabel = '3 min';
const String k1minLabel = '1 min';

class CountdownTextFormat {
  static const String HH_MM_SS = "HH:mm:ss";
  static const String MM_SS = "mm:ss";
  static const String SS = "ss";
  static const String S = "s";
}
