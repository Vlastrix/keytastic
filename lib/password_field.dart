import 'package:flutter/material.dart';

import './keytastic_colors.dart';

class PasswordField extends StatefulWidget {
  String? password;
  PasswordField({super.key, this.password});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {},
      onChanged: (value) {
        widget.password = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        filled: true,
        fillColor: KeyTasticColors().keytasticWhite,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2, color: KeyTasticColors().keytasticYellow),
        ),
      ),
    );
  }
}
