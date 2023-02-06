import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'dart:async';

import './keytastic_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final FancyPasswordController _passwordController = FancyPasswordController();
  double confirmPassEdgeInsetsValue = 10;
  String? username;
  String? email;
  String? password;
  String? confirmPassword;

  void changeEdgeInstets(value) {
    setState(() {
      confirmPassEdgeInsetsValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
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
                validator: (enteredUsername) {
                  if (enteredUsername == null || enteredUsername.isEmpty) {
                    return 'Please enter some text.';
                  } else if (enteredUsername.contains(' ')) {
                    return 'Username cannot contain spaces.';
                  } else if (enteredUsername.length < 3) {
                    return 'Username should be more than 3 characters';
                  } else if (!RegExp(r'^[A-Za-z0-9_.]+$')
                      .hasMatch(enteredUsername)) {
                    return 'Only latin, underscores and dots characters.';
                  }
                  return null;
                },
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: KeyTasticColors().keytasticYellow),
                  hintText: 'Username',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: KeyTasticColors().keytasticYellow,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 346,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autofillHints: const [AutofillHints.email],
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
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: KeyTasticColors().keytasticYellow),
                  hintText: 'Email',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: const OutlineInputBorder(),
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
              child: FancyPasswordField(
                hasShowHidePassword: true,
                passwordController: _passwordController,
                validator: (enteredPassword) {
                  if (enteredPassword == null || enteredPassword.isEmpty) {
                    return 'Please enter some text.';
                  } else if (enteredPassword.contains(' ')) {
                    return 'Passwords cannot contain spaces.';
                  } else if (!RegExp(
                          r'^[A-Za-z0-9_\.!@=#\$%\^&\*\(\)\?\+\{\}\[\]\|\-`~:;]+$')
                      .hasMatch(enteredPassword)) {
                    return 'Only latin characters are accepted.';
                  } else if (!_passwordController.areAllRulesValidated) {
                    return 'Specified rules not validated.';
                  }
                  return null;
                },
                validationRuleBuilder: (rules, value) {
                  if (value.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: rules
                            .map(
                              (rule) => rule.validate(value)
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          color:
                                              KeyTasticColors().keytasticYellow,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          rule.name,
                                          style: TextStyle(
                                            color: KeyTasticColors()
                                                .keytasticYellow,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Icon(
                                          Icons.close,
                                          color:
                                              KeyTasticColors().keytasticWhite,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          rule.name,
                                          style: TextStyle(
                                            color: KeyTasticColors()
                                                .keytasticWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                },
                hasStrengthIndicator: false,
                validationRules: {
                  DigitValidationRule(),
                  UppercaseValidationRule(),
                  LowercaseValidationRule(),
                  SpecialCharacterValidationRule(),
                  MinCharactersValidationRule(6),
                },
                onChanged: (enteredPassword) {
                  if (enteredPassword.isNotEmpty) {
                    changeEdgeInstets(0);
                  } else {
                    changeEdgeInstets(10);
                  }
                  password = enteredPassword;
                },
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: KeyTasticColors().keytasticYellow),
                  hintText: 'Password',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: KeyTasticColors().keytasticYellow),
                  ),
                ),
              ),
            ),
            Container(
              width: 346,
              padding:
                  EdgeInsets.fromLTRB(10, confirmPassEdgeInsetsValue, 10, 10),
              child: TextFormField(
                obscureText: true,
                validator: (enteredConfirmPassword) {
                  if (enteredConfirmPassword == null ||
                      enteredConfirmPassword.isEmpty) {
                    return 'Please enter some text.';
                  } else if (enteredConfirmPassword != password) {
                    return 'Passwords does not match.';
                  }
                  return null;
                },
                onChanged: (enteredConfirmPassword) {
                  confirmPassword = enteredConfirmPassword;
                },
                decoration: InputDecoration(
                  errorStyle:
                      TextStyle(color: KeyTasticColors().keytasticYellow),
                  hintText: 'Confirm Password',
                  filled: true,
                  fillColor: KeyTasticColors().keytasticWhite,
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: KeyTasticColors().keytasticYellow),
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
                    signUpSendToServer(username, email, password).then((serverResponse) {
                      print(serverResponse.body);
                    });
                    // var serverResponse =
                    //     signUpSendToServer(username, email, password);
                    // sleep(const Duration(seconds: 4));
                    // serverResponse['statusCode'];
                    // serverResponse['body'];
                    // if (serverResponse['statusCode'] == 200) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(serverResponse['body'] as String),
                    //     ),
                    //   );
                    // }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    KeyTasticColors().keytasticCyan,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(20),
                  ),
                ),
                child: const Text(
                  'Sign Up',
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
                  'Already have an account?',
                  style: TextStyle(color: KeyTasticColors().keytasticWhite),
                ),
                TextButton(
                  onPressed: () {
                    // Implement Screen to Sign In
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
  return response;
}
