import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import './keytastic_colors.dart';
import './password_field.dart';
import './signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                validator: (value) {},
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: KeyTasticColors().keytasticYellow),
                  ),
                ),
              ),
            ),
            Container(
              width: 346,
              padding: const EdgeInsets.all(10),
              child: PasswordField(),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              width: 328,
              child: ElevatedButton(
                onPressed: () {
                  signInSendToServer(email, password);
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
                  style: TextStyle(color: KeyTasticColors().keytasticWhite),
                ),
                TextButton(
                  onPressed: () {
                    // Implement screen to Sign Up!
                  },
                  child: Text(
                    'Sign Up!',
                    style: TextStyle(color: KeyTasticColors().keytasticYellow),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

signInSendToServer(email, password) async {
  await dotenv.load(fileName: ".env");
  String serverUrl = '${dotenv.env['SERVER_URL']}/signin';
  final response = await http.post(
    Uri.parse(serverUrl),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      'email': email,
      'password': password,
    },
  );
}
