import 'package:flutter/material.dart';
import 'package:todo_app_frontend/screens/signup.dart';
import 'package:todo_app_frontend/screens/todos.dart';

import '../services/userService.dart';

class LoginScreen extends StatefulWidget {
  void login() {
    //  bool res = await UserService().login(
    //             formValue["email"].toString().trim(),
    //             formValue["password"].toString().trim(),
    //           );
    //           if (res) {
    //             Navigator.of(context).pushReplacement(
    //                 MaterialPageRoute(builder: (context) => TodoScreen()));
    //           } else {
    //             print(res);
    //             // return showDialog(
    //             //   context: context,
    //             //   barrierDismissible: false,
    //             //   builder: (BuildContext context) {
    //             //     return AlertDialog(
    //             //       title: Text("Error"),
    //             //       content: Text("Please check Username Or Password"),
    //             //       actions: <Widget>[
    //             //         FlatButton(
    //             //           child: Text("Okay"),
    //             //           onPressed: () {
    //             //             Navigator.of(context).pop();
    //             //           },
    //             //         )
    //             //       ],
    //             //     );
    //             //   },
    //             // );
    //           }
  }

  static String tag = "page-login";

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'imageLogo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 50.0,
        child: Image.asset('assets/todo.jpg'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
      ),
      initialValue: 'dhananjay@example.com',
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Enter Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
      ),
      initialValue: 'qwerty123',
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        //shadowColor: Colors.lightBlueAccent,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          color: Colors.lightBlue,
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          height: 48.0,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TodoScreen()));
          },
        ),
      ),
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(25.0),
        //shadowColor: Colors.lightBlueAccent,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          color: Colors.lightBlue,
          child: Text(
            "Signup",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          height: 48.0,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignupScreen()));
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 50.0),
            email,
            SizedBox(height: 18.0),
            password,
            SizedBox(height: 18.0),
            loginButton,
            signupButton
          ],
        ),
      ),
    );
  }
}
