import 'package:flutter/material.dart';

var textInputDecorationStyle1 = InputDecoration(
  hintStyle: TextStyle(color: Colors.blue[100], fontSize: 15),
  border: UnderlineInputBorder(),
  // fillColor: Colors.white,
  // filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
);
var buttonAuthenticateStyle1 = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8.0)),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Colors.white)
    )
  ),
);

var textInputDecorationAuthPages = InputDecoration(
  hintStyle: TextStyle(color: Color.fromRGBO(198, 198, 198, 1), fontSize: 16),
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(237, 237, 237, 1),
      width: 1,
    )
  ),
);

var labelStyleAuthPages = TextStyle(
  color: Color.fromRGBO(49, 49, 49, 1), 
  fontSize: 20,
  fontWeight: FontWeight.w400,
);

var textDateStyle = TextStyle(
  color: Color.fromRGBO(154, 154, 154, 1),
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

var textTaskTile = TextStyle(
  color: Color.fromRGBO(49, 49, 49, 1),
  fontSize: 16,
  fontWeight: FontWeight.w400,
);


var textTaskDateTimeNotDone = TextStyle(
  color: Color.fromRGBO(154, 154, 154, 1),
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

var textTaskDateTimeDone = TextStyle(
  color: Color.fromRGBO(158, 158, 158, 1),
  fontSize: 16,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.lineThrough,
);

var taskItemBoxDecoration = BoxDecoration(
  color: Colors.white10,
 border: Border(
   right: BorderSide(width: 0.5, color: Colors.black, style: BorderStyle.solid),
 ),
);

var buttonStyleAuthPages =  ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(249, 96, 96, 1)),
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13.0)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Colors.white)
    )
  ),
);