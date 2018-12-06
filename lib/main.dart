import 'package:flutter/material.dart';
import 'package:todo_app_frontend/login.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoAppState();
  }
}

class TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
