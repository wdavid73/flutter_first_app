import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonsCrid extends StatefulWidget {
  @override
  _ButtonsCridState createState() => _ButtonsCridState();
}

class _ButtonsCridState extends State<ButtonsCrid> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buttons Crids",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: responsive.height,
        child: Stack(
          children: [
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
            Center(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(
                    vertical: responsive.height * 0.2, horizontal: 20),
                physics: PageScrollPhysics(),
                children: [
                  FlatButton(
                    onPressed: () => print("button 1"),
                    child: Text("button 1"),
                    color: Colors.red,
                    height: 10,
                  ),
                  FlatButton(
                    onPressed: () => print("button 2"),
                    child: Text("button 2"),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FlatButton(
                    onPressed: () => print("button 2"),
                    child: Text("button 3"),
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    onPressed: () => print("button 4"),
                    child: Text("button 4"),
                    color: Colors.green,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
