import 'package:flutter/material.dart';

// Color Scheme
const PrimaryColor = const Color(0xff14213D);
const SecondaryColor = const Color(0xffFCA311);
const BlackShade = const Color(0xff1A1A1A);
const TextIconColor = const Color(0xffffffff);
const LinkColor = const Color(0xffFCA311);
const DividerColor = const Color(0xff666666);
const DisabledColor = const Color(0xff666666);

//App Styles
const AppBackgroundColor = PrimaryColor;
const AppBarColor = BlackShade;
const ButtonBackgroundColor = LinkColor;
const ButtonTextCOlor = TextIconColor;

getTextField(hint, controller) {
  return TextField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: getTextFieldDecoration(hint));
}

getTextFieldDecoration(hint) {
  return InputDecoration(
    fillColor: Colors.white12,
    filled: true,
    enabledBorder: const OutlineInputBorder(
      // width: 0.0 produces a thin "hairline" border
      borderSide: const BorderSide(color: Colors.white, width: 0.0),
    ),
    hintStyle: TextStyle(color: Colors.white),
    hintText: hint,
  );
}
