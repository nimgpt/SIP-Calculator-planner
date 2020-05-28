import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Roboto',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Roboto',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.lightBlue[400],
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
