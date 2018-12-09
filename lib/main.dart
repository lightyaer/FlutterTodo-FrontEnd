import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_frontend/screens/login.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  isDebugMode() async {
    bool res = const bool.fromEnvironment("dart.vm.product");
    if (res) {
      //PROD MODE
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('server-url', '');
    } else {
      //DEBUG MODE
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('server-url', 'http://10.0.2.2:3000');
    }
  }

  @override
  Widget build(BuildContext context) {
    this.isDebugMode();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: LoginScreen(),
    );
  }
}
