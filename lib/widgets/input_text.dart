import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatelessWidget {
  final String label;
  final TextInputType type;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final void Function(String text) onChanged;
  final String Function(String text) validator;

  const InputText({
    Key key,
    this.label = '',
    this.type = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.type,
      obscureText: this.obscureText,
      style: TextStyle(fontSize: this.fontSize),
      onChanged: this.onChanged,
      validator: this.validator,
      decoration: InputDecoration(
        //suffix: Text('Forgot Password'),
        enabledBorder: this.borderEnabled
            ? UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black12,
                ),
              )
            : InputBorder.none,
        labelText: this.label,
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        labelStyle: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
