import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import './services/userService.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  login(String email, String password) {
    UserService().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(children: <Widget>[
          //LOGO
          Expanded(child: Container()),
          Container(
            child: Text(
              "To-Do's",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 100.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 45.0, right: 45.0),
            child: FormBuilder(
              context,
              autovalidate: true,
              controls: [
                FormBuilderInput.textField(
                  type: FormBuilderInput.TYPE_EMAIL,
                  label: "Email",
                  min: 10,
                  require: true,
                  attribute: "email",
                ),
                FormBuilderInput.password(
                  label: "Password",
                  attribute: "password",
                  min: 3,
                  require: true,
                )
              ],
              submitButtonContent: Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text("Login"),
              ),
              onSubmit: (formValue) async {
                this.login(formValue["email"], formValue["password"]);
              },
            ),
          ),
          Expanded(child: Container()),
        ]),
      ),
    );
  }
}
