import 'package:flutter/material.dart';

import './screens/dashboard_screen.dart';
import './screens/signup_screen.dart';
import './screens/signin_screen.dart';
import './models/keytastic_colors.dart';

void main() {
  runApp(const KeyTastic());
}

class KeyTastic extends StatelessWidget {
  const KeyTastic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignInScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/signup': (context) => SignUpScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: KeyTasticColors.keytasticDarkRed,
        fontFamily: 'Comfortaa',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: KeyTasticColors.keytasticDarkRed,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'KeyTastic!',
    );
  }
}
