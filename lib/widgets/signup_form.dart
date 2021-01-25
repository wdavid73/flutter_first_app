import 'package:first_app/pages/home_page.dart';
import 'package:first_app/services/services.dart';
import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  RestClientService restClientService = RestClientService();
  GlobalKey<FormState> _formKey = GlobalKey();
  // ignore: non_constant_identifier_names
  String _name = '', _last_name = '', _address = '';
  int _phone = 0, _cellphone = 0;
  double _currentSliderValue = 0;
  bool _checkedValue = false;

  _submit() async {
    final isOK = _formKey.currentState.validate();
    if (isOK) {
      Map<String, dynamic> data = {
        "name": _name,
        "last_name": _last_name,
        "address": _address,
        "phone": _phone,
        "cellphone": _cellphone
      };
      await restClientService.post("/clients/", data).then((value) {
        if (value.statusCode == 0) {
          //Navigator.of(context).push(_createRoute());
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            SystemNavigator.pop();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Ah Ocurrido un Error"),
            duration: Duration(seconds: 5),
            backgroundColor: Colors.pinkAccent,
            elevation: 5,
          ));
        }
      });
      print("isOk is : ${isOK}");
    }
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
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
                label: 'name',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _name = text;
                },
                validator: (text) {
                  if (text.trim().length != 0) {
                    return null;
                  }
                  return "invalid name";
                },
              ),
              SizedBox(
                height: responsive.dp(1.5),
              ),
              InputText(
                type: TextInputType.text,
                label: 'last name',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _last_name = text;
                },
                validator: (text) {
                  if (text.trim().length != 0) {
                    return null;
                  }
                  return "invalid last name";
                },
              ),
              SizedBox(
                height: responsive.dp(1.5),
              ),
              InputText(
                type: TextInputType.text,
                label: 'address',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _address = text;
                },
                validator: (text) {
                  if (text.trim().length != 0) {
                    return null;
                  }
                  return "invalid address";
                },
              ),
              SizedBox(
                height: responsive.dp(1.5),
              ),
              InputText(
                type: TextInputType.phone,
                label: 'phone',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _phone = int.parse(text);
                },
                validator: (text) {
                  if (text.trim().length != 0) {
                    return null;
                  }
                  return "invalid phone";
                },
              ),
              SizedBox(
                height: responsive.dp(1.5),
              ),
              InputText(
                type: TextInputType.phone,
                label: 'cellphone',
                fontSize: responsive.dp(1.4),
                onChanged: (text) {
                  _cellphone = int.parse(text);
                },
                validator: (text) {
                  if (text.trim().length != 0) {
                    return null;
                  }
                  return "invalid cellphone";
                },
              ),
              CheckboxListTile(
                title: Text("title text"),
                value: _checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    _checkedValue = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 20,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    this._submit();
                  },
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.6),
                    ),
                  ),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.deepOrangeAccent,
                ),
              ),
              SizedBox(
                height: responsive.dp(7),
              )
            ],
          ),
        ),
      ),
    );
  }
}
