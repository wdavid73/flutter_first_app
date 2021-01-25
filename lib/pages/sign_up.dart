import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/circle.dart';
import 'package:first_app/widgets/icon_container.dart';
import 'package:first_app/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sing Up",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
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
                        size: responsive.wp(35),
                      ),
                    ],
                  ),
                ),
                //LoginForm()
                SignUpForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
