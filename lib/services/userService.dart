import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/users/login';
    var body = json.encode({"email": email, "password": password});

    var res = await http.post(url,
        headers: {'Content-type': 'application/json'}, body: body);

    await prefs.setString("x-auth", res.headers["x-auth"]);
    
  }

  logout(String token) async {
    String url = 'http://10.0.2.2:3000/users/me/token';
    var response = await http.post(url, headers: {"x-auth": token});
    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
