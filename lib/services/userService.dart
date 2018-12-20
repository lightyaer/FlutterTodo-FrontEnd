import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_frontend/models/user.dart';

class UserService {
  Future<User> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('server-url');
    String url = server + '/users/login';
    var body = json.encode({"email": email, "password": password});

    var res = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: body,
    );

    await prefs.setString("x-auth", res.headers["x-auth"]);

    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    } else {
      return User.formError(json.decode(res.body));
    }
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('server-url');
    String url = server + '/users/me/token';

    String token = prefs.getString('x-auth');
    var res = await http.delete(
      url,
      headers: {
        'Content-type': 'application/json',
        "x-auth": token,
      },
    );

    await prefs.remove("x-auth");

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> signup(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('server-url');
    String url = server + "/users";
    var body = json.encode({"email": email, "password": password});

    var res = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: body,
    );
    await prefs.setString("x-auth", res.headers["x-auth"]);
    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    } else {
      return User.formError(json.decode(res.body));
    }
  }

  Future<User> getInfo() async {
    User user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('server-url');

    String url = server + "/users/me/token";

    String token = prefs.getString("x-auth");
    var res = await http.delete(
      url,
      headers: {'x-auth': token},
    );
    user = User.fromJson(json.decode(res.body));
    if (res.statusCode == 200) {
      return user;
    } else {
      return User();
    }
  }
}
