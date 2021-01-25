import 'package:first_app/pages/ButtonsCrid.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/list_client.dart';
import 'package:first_app/pages/sign_up.dart';
import 'package:flutter/material.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
  "/list_clients": (BuildContext context) => ListClients(),
  //"/details_clients": (BuildContext context) => ClientDetails(),
  "/buttons_grid": (BuildContext context) => ButtonsCrid(),
  "/signup": (BuildContext context) => SignUp(),
};
