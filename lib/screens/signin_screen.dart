import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';

import '../models/keytastic_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  void checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? readJsonWebToken = prefs.getString('token');
    if (readJsonWebToken != null) {
      // send user to the next screen
    }
  }

  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    checkToken();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In!',
                  style: TextStyle(
                      fontSize: 40, color: KeyTasticColors.keytasticYellow),
                ),
                SizedBox(
                  height: 20.0,
                  width: 200.0,
                  child: Divider(
                    color: KeyTasticColors.keytasticWhite,
                  ),
                ),
                Container(
                  width: 346,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (enteredEmail) {
                      if (enteredEmail == null || enteredEmail.isEmpty) {
                        return 'Please enter some text.';
                      } else if (enteredEmail.contains(' ')) {
                        return 'Emails cannot contain spaces.';
                      } else if (!RegExp(r'^[a-z0-9_.@]+$')
                          .hasMatch(enteredEmail)) {
                        return 'Only lowercase letters and latin characters.';
                      } else if (!EmailValidator.validate(email as String)) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                    onChanged: (enteredEmail) {
                      email = enteredEmail;
                    },
                    decoration: InputDecoration(
                      errorStyle:
                          TextStyle(color: KeyTasticColors.keytasticYellow),
                      hintText: 'Email',
                      filled: true,
                      fillColor: KeyTasticColors.keytasticWhite,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: KeyTasticColors.keytasticYellow),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 346,
                  padding: const EdgeInsets.all(10),
                  child: FancyPasswordField(
                    validator: (enteredPassword) {
                      if (enteredPassword == null || enteredPassword.isEmpty) {
                        return 'Please enter some text.';
                      } else if (enteredPassword.contains(' ')) {
                        return 'Passwords cannot contain spaces.';
                      } else if (!RegExp(
                              r'^[A-Za-z0-9_\.!@=#\$%\^&\*\(\)\?\+\[\]\|\-`~:;]+$')
                          .hasMatch(enteredPassword)) {
                        return 'Only latin characters are accepted.';
                      }
                      return null;
                    },
                    onChanged: (enteredPassword) {
                      password = enteredPassword;
                    },
                    hasValidationRules: false,
                    hasStrengthIndicator: false,
                    decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(color: KeyTasticColors.keytasticYellow),
                      hintText: 'Password',
                      filled: true,
                      fillColor: KeyTasticColors.keytasticWhite,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: KeyTasticColors.keytasticYellow),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 328,
                  child: ElevatedButton(
                    onPressed: () {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        signInSendToServer(email, password)
                            .then((serverResponse) async {
                          if (serverResponse.statusCode == 200) {
                            // save the token
                            final prefs = await SharedPreferences.getInstance();
                            var receivedJsonWebToken =
                                jsonDecode(serverResponse.body)['token'];
                            await prefs.setString(
                                'token', receivedJsonWebToken);
                            Navigator.pushNamed(context, '/dashboard');
                          } else if (serverResponse.statusCode == 404) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  serverResponse.body,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          } else if (serverResponse.statusCode == 403) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  serverResponse.body,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          } else if (serverResponse.statusCode == 400) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  serverResponse.body,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          } else if (serverResponse.statusCode == 500) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  serverResponse.body,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        KeyTasticColors.keytasticCyan,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(20),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: KeyTasticColors.keytasticWhite),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Sign Up!',
                        style:
                            TextStyle(color: KeyTasticColors.keytasticYellow),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
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
  return response;
}
