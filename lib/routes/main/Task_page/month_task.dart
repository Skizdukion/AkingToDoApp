import 'package:flutter/material.dart';

import 'calendar.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({ Key? key }) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TaskCalendar(),
    );
  }
}