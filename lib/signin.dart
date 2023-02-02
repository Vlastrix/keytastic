import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';

import './keytastic_colors.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: KeyTasticColors().keytasticDarkRed,
            fontFamily: 'Comfortaa'),
        debugShowCheckedModeBanner: false,
        title: 'KeyTastic!',
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TODO: CREATE AND ADD THE NEW LOGO HERE
                  Text(
                    'Sign In!',
                    style: TextStyle(
                        fontSize: 40, color: KeyTasticColors().keytasticYellow),
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 200.0,
                    child: Divider(
                      color: KeyTasticColors().keytasticWhite,
                    ),
                  ),
                  Container(
                    width: 346,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: KeyTasticColors().keytasticWhite,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: KeyTasticColors().keytasticYellow))),
                    ),
                  ),
                  Container(
                    width: 346,
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: KeyTasticColors().keytasticWhite,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: KeyTasticColors().keytasticYellow))),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: 328,
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement Sign In
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(fontSize: 15),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          KeyTasticColors().keytasticCyan,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style:
                            TextStyle(color: KeyTasticColors().keytasticWhite),
                      ),
                      TextButton(
                        onPressed: () {
                          // Sing Up Screen
                        },
                        child: Text(
                          'Sign Up!',
                          style: TextStyle(
                              color: KeyTasticColors().keytasticYellow),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
