import 'package:flutter/material.dart';

class AppInputDecoration {
  static InputDecoration underLineBorder = InputDecoration(
    hintStyle: TextStyle(color: Colors.blue[100], fontSize: 15),
    border: UnderlineInputBorder(),
    // fillColor: Colors.white,
    // filled: true,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
  );

  static InputDecoration authPages = InputDecoration(
    hintStyle: TextStyle(color: Color.fromRGBO(198, 198, 198, 1), fontSize: 16),
    border: UnderlineInputBorder(
        borderSide: BorderSide(
      color: Color.fromRGBO(237, 237, 237, 1),
      width: 1,
    )),
  );
}
