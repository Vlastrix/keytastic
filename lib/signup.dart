import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:passwordfield/passwordfield.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import './keytastic_colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    String? username;
    String? email;
    String? password;
    String? confirmPassword;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create an account!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: KeyTasticColors().keytasticYellow,
            ),
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
              onChanged: (value) {
                username = value;
              },
              decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: KeyTasticColors().keytasticYellow))),
            ),
          ),
          Container(
            width: 346,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
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
                          width: 2, color: KeyTasticColors().keytasticYellow))),
            ),
          ),
          Container(
            width: 346,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: KeyTasticColors().keytasticYellow))),
            ),
          ),
          Container(
            width: 346,
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) {
                confirmPassword = value;
              },
              decoration: InputDecoration(
                hintText: 'Confirm Password',
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
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 328,
            child: ElevatedButton(
              onPressed: () {
                signUpSendToServer(username, email, password);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  KeyTasticColors().keytasticCyan,
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(20),
                ),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 15),
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
                'Already have an account?',
                style: TextStyle(color: KeyTasticColors().keytasticWhite),
              ),
              TextButton(
                onPressed: () {
                  // Sign In Screen
                },
                child: Text(
                  'Sign In!',
                  style: TextStyle(color: KeyTasticColors().keytasticYellow),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

signUpSendToServer(username, email, password) async {
  await dotenv.load(fileName: ".env");
  String serverUrl = '${dotenv.env['SERVER_URL']}/signup';
  final response = await http.post(
    Uri.parse(serverUrl),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    encoding: Encoding.getByName('utf-8'),
    body: {
      'username': username,
      'email': email,
      'password': password,
      'favoriteKeyboards': ''
    },
  );
}
