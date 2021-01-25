import 'package:first_app/pages/list_client.dart';
import 'package:first_app/services/services.dart';
import 'package:first_app/utils/navigator.dart';
import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_indicator_button/progress_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  RestClientService restClientService = RestClientService();
  GlobalKey<FormState> _formKey = GlobalKey();
  String _username = '', _password = '';
  bool _loading = false;

  void httpJob(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }

  void _submit(AnimationController controller) async {
    controller.forward();
    final isOK = _formKey.currentState.validate();
    // Map<String, dynamic> data = {
    //   "name": _username,
    //   "last_name": _password,
    //   "cellphone": '123456',
    //   "address": "async",
    //   "phone": '123456'
    // };
    if (isOK) {
      print("isOk");
      //await Future.delayed(Duration(seconds: 2), () {});
      // await restClientService.post("/clients/", data).then((value) {
      //   if (value.statusCode == 0) {
      //     Navigator.of(context).push(_createRoute());
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text("ah ocurrido un Error"),
      //       backgroundColor: Colors.pinkAccent,
      //       duration: Duration(seconds: 2),
      //     ));
      //   }
      // });
      await Future.delayed(Duration(seconds: 2), () {
        /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListClients()));*/
        MyNavigator.goToListClients(context);
      });
    }
    controller.reset();
  }

  _signup() {
    MyNavigator.goToSignUp(context);
    //Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ListClients(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 335,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                type: TextInputType.text,
                label: 'Username',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text.trim().length <= 0) {
                    return "invalid username";
                  }
                  return null;
                },
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        obscureText: true,
                        label: 'Password',
                        borderEnabled: false,
                        fontSize: responsive.dp(1.4),
                        onChanged: (text) {
                          _password = text;
                        },
                        validator: (text) {
                          if (text.trim().length == 0 &&
                              text.trim().length > 6) {
                            return "password invalid";
                          }
                          return null;
                        },
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('Forgot Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.dp(1.6),
                          )),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: ProgressButton(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    strokeWidth: 2,
                    child: Text("Sign In",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: responsive.dp(1.6),
                        )),
                    onPressed: (AnimationController controller) async {
                      await _submit(controller);
                    }),
                /*FlatButton(
                  onPressed: () {
                    this._submit();
                  },
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: responsive.dp(1.6),
                    ),
                  ),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                ),*/
              ),
              SizedBox(
                height: responsive.dp(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You dont have an account?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.6),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      this._signup();
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.6),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//print('username ${_username}');
//print('password ${_password}');
