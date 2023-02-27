import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/authentication_controller.dart';
import '../models/keytastic_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool tokenChecked = false;
  void checkToken() {
    if (tokenChecked == false) {
      AuthenticationController.verifyToken(context);
      tokenChecked = true;
    }
  }

  getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    return username;
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    checkToken();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: KeyTasticColors.keytasticWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: getUsername(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'What\'s Cookin\' ${snapshot.data}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: KeyTasticColors.keytasticDarkCyan),
                    ),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: const Text(
                  'Showing most popular keyboards:',
                  style: TextStyle(
                      fontSize: 18, color: KeyTasticColors.keytasticDarkCyan),
                ),
              ),
              SizedBox(
                height: deviceHeight,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale $index'),
                              subtitle: Text(
                                  'Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('BUY TICKETS'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('LISTEN'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
