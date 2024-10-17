import 'package:flutter/material.dart';
import 'package:weather_app_flutter/constants/constants.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: appTextStyle(),
      ),
      backgroundColor: Colors.black,
    ),
  );
}
