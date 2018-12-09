import 'package:flutter/material.dart';
import 'package:todo_app_frontend/UI/alert.dart';
import 'package:todo_app_frontend/models/user.dart';
import 'package:todo_app_frontend/screens/todos.dart';
import 'package:todo_app_frontend/services/userService.dart';

class SignupScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

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

    final retypePassword = TextFormField(
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
            Future<User> res = UserService()
                .signup(emailController.text, passwordController.text);
            res.then((user) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TodoScreen(
                        email: user.email,
                      )));
            }).catchError((onError) {
              Alert()
                  .showInfoAlert(context, "Error", "Passwords do not match.");
            });
          },
        ),
      ),
    );

    return Scaffold(
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
            retypePassword,
            SizedBox(height: 18.0),
            signupButton
          ],
        ),
      ),
    );
  }
}
