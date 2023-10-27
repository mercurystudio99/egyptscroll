import 'package:flutter/material.dart';

class NavigationRouter {
  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void gotoHome(BuildContext context) {
    Navigator.pushNamed(context, "/Home");
  }
}
