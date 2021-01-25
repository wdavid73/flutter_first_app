import 'package:first_app/pages/splash_screen.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/material.dart';

/*var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};*/

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.yellowAccent,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes,
      ),
    );
