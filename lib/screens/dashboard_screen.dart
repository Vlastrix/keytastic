import 'package:flutter/material.dart';
import 'package:keytastic/models/keytastic_colors.dart';

import '../controllers/authentication_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('KeyTastic!');
  bool tokenChecked = false;
  void checkToken() {
    if (tokenChecked == false) {
      AuthenticationController.verifyToken(context);
      tokenChecked = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkToken();
    return Scaffold(
      backgroundColor: KeyTasticColors.keytasticWhite,
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: KeyTasticColors.keytasticWhite,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'search for a keyboard here...',
                          hintStyle: TextStyle(
                            color: KeyTasticColors.keytasticWhite,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: KeyTasticColors.keytasticWhite,
                        ),
                      ),
                    );
                  }
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('KeyTastic!');
                }
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body: ListView(
        children: const [Text('data')],
      ),
    );
  }
}
