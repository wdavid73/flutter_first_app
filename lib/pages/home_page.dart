import 'dart:io';

import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/circle.dart';
import 'package:first_app/widgets/icon_container.dart';
import 'package:first_app/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// class HomePage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  String title;

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);

    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: responsive.height,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: -pinkSize * 0.4,
                    right: -pinkSize * 0.2,
                    child: Circle(
                      size: pinkSize,
                      colors: [
                        Colors.pink,
                        Colors.pinkAccent,
                      ],
                    ),
                  ),
                  Positioned(
                    top: -orangeSize * 0.55,
                    left: -orangeSize * 0.15,
                    child: Circle(
                      size: orangeSize,
                      colors: [
                        Colors.deepOrange,
                        Colors.deepOrangeAccent,
                      ],
                    ),
                  ),
                  Positioned(
                    top: pinkSize * 0.35,
                    child: Column(
                      children: [
                        IconContainer(
                          size: responsive.wp(20),
                        ),
                        SizedBox(
                          height: responsive.hp(3),
                        ),
                        Text(
                          'My first app in Flutter',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: responsive.dp(1.5)),
                        )
                      ],
                    ),
                  ),
                  LoginForm(),
                  SizedBox(
                    height: responsive.dp(5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("toast");
      Fluttertoast.showToast(msg: "Presiones otra vez para salir");
      return Future.value(false);
    }
    exit(0);
    // return Future.value(true);
  }
}
