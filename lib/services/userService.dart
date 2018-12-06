import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_frontend/models/user.dart';

class UserService {
  Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/users/login';
    var body = json.encode({"email": email, "password": password});

    try {
      var res = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: body,
      );
      await prefs.setString("x-auth", res.headers["x-auth"]);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/users/me/token';
    try {
      String token = prefs.getString('x-auth');
      var res = await http.post(
        url,
        headers: {"x-auth": token},
      );

      await prefs.remove("x-auth");
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> signup(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "http:10.0.2.2:3000/users";
    var body = json.encode({"email": email, "password": password});
    try {
      var res = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: body,
      );
      await prefs.setString("x-auth", res.headers["x-auth"]);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<User> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user;
    String url = "http:10.0.2.2:3000/users/me/token";
    try {
      String token = prefs.getString("x-auth");
      var res = await http.delete(
        url,
        headers: {'x-auth': token},
      );
      var body = json.decode(res.body);
      user = User(body.email, body.password);
    } catch (e) {
      return User("", "");
    }
    return user;
  }
}
