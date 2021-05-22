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
//const Color RaisinBlack = Color(0xff);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
