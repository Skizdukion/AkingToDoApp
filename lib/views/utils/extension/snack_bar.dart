import 'package:flutter/material.dart';
import 'package:todo_app/utils/frequent_use_fuction.dart';

extension ExpandedSnackBar on SnackBar {
  static SnackBar statusSnackBar(BuildContext context, List<Widget> children,
      {Duration? duration, Color? color}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color ?? Theme.of(context).primaryColorDark,
      duration: duration ?? Duration(milliseconds: 4000),
      elevation: 2.0,
    );
  }

  static SnackBar successSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          textMessage,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
        Icon(
          Icons.check,
          color: Colors.white,
        ),
      ],
      duration: Duration(milliseconds: 1000),
    );
  }

  static SnackBar failureSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          limitString(textMessage, 40),
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.red),
        ),
        Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
      ],
      color: Colors.white,
      duration: Duration(milliseconds: 2000),
    );
  }
}
