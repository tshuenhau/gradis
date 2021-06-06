import 'dart:ui';
import 'package:flutter/material.dart';

const Color DarkCharcoal = Color(0xff303030);
const Color DarkLiver = Color(0xff505050);
const Color Gainsboro = Color(0xffDCDCDC);
const Color LightGrey = Color(0xffD5D5D5);
const Color QuickSilver = Color(0xffA4A4A4);
const Color RaisinBlack = Color(0xff202124);
const Color CharlestonGreen = Color(0xff282C2F);
const Color Onyx = Color(0xff323639);
const Color LightSilver = Color(0xffD6D6D7);

const Color BlueAccent = Color(0xff09A6F3);
const Color BlueHighlight = Color(0xff07c8f9);
const Color DeepBlueHighlight = Color(0xff0a85ed);
// const Color Highlight = Color(0xff21b17b);

const Color GreenHighlight = Color(0xff42dca3);

const Color Highlight = Color(0xff21e6c1);

const Color Accent = Color(0xff3edbf0);

const Color BackgroundColor = Color(0xff071e3d);

const Color Blue = Color(0xff1f4287);

const Color PrimaryColor = Color(0xff121212);

const Color ModuleTileColor = Color(0xff222222);

const Color ScaffoldBackgroundColor = Color(0xff202020);

const Color BorderColor = Color(0xffc0fefc);
const Color IconsColor = Colors.white60;

ThemeData gradisTheme = ThemeData.dark().copyWith(
  primaryColor: PrimaryColor,
  appBarTheme: AppBarTheme(
    color: PrimaryColor,
  ),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: RaisinBlack),
  accentColor: Accent,
  backgroundColor: BackgroundColor,
  scaffoldBackgroundColor: ScaffoldBackgroundColor,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Highlight.withOpacity(.6),
    selectionHandleColor: Highlight.withOpacity(1),
  ),
);

//const Color RaisinBlack = Color(0xff);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Blue,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Accent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Accent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const greenTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Highlight,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Highlight, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Highlight, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const TextStyle capTextStyle = TextStyle(
  color: Colors.white70,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
);
const TextStyle titleTextStyle = TextStyle(
  color: Colors.white70,
  fontSize: 10.0,
  fontWeight: FontWeight.w400,
);
