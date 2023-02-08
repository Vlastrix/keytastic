import 'package:flutter/material.dart';

import './signup.dart';
import './signin.dart';
import './keytastic_colors.dart';
import './dashboard.dart';

void main() {
  runApp(const KeyTastic());
}

class KeyTastic extends StatelessWidget {
  const KeyTastic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: KeyTasticColors.keytasticDarkRed,
        fontFamily: 'Comfortaa',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: KeyTasticColors.keytasticDarkRed,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'KeyTastic!',
      home: Scaffold(
          body: SafeArea(
        child: SignUp(),
      )),
    );
  }
}
