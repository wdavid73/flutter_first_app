import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToListClients(BuildContext context) {
    Navigator.pushNamed(context, "/list_clients");
  }

  /*static void goToDetailsClients(BuildContext context, Client client) {
    Navigator.pushNamed(context, "/details_clients");
  }*/

  static void goToButtonsGrid(BuildContext context) {
    Navigator.pushNamed(context, "/buttons_grid");
  }

  static void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, "/signup");
  }
}
