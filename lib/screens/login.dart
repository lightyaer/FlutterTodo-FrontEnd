import 'package:flutter/material.dart';
import 'package:todo_app_frontend/UI/alert.dart';

import 'package:todo_app_frontend/models/user.dart';
import 'package:todo_app_frontend/screens/signup.dart';
import 'package:todo_app_frontend/screens/todos.dart';
import '../services/userService.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
      controller: emailController,
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
      //initialValue: 'dhananjay@example.com',
    );

    final password = TextFormField(
      controller: passwordController,
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
      //initialValue: 'qwerty123',
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
            Future<User> user = UserService()
                .login(emailController.text, passwordController.text);
            user.then(
              (user) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TodoScreen(
                          email: user.email,
                        )));
              },
            ).catchError((err) {
              Alert().showInfoAlert(context, "Error", err);
            });
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
          padding: EdgeInsets.only(left: 25.0, right: 25.0),
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
