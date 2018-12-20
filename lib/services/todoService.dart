import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_app_frontend/models/todo.dart';

class TodoService {
  Future<List<Todo>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos';
    String token = prefs.getString('x-auth');
    var res = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
    );

    return parseTodos(res.body);
  }

  List<Todo> parseTodos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
  }

  Future<Todo> getByID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/' + id;
    Todo todo;

    String token = prefs.getString('x-auth');
    var res = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
    );
    todo = Todo.fromJson(json.decode(res.body));
    return todo;
  }

  Future<Todo> createTodo(Todo todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/';
    var body = json.encode({"text": todo.text});
    String token = prefs.getString('x-auth');
    var res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
      body: body,
    );
    return Todo.fromJson(json.decode(res.body));
  }

  Future<Todo> deleteByID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/' + id;
    Todo todo;

    String token = prefs.getString('x-auth');
    var res = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
    );
    todo = json.decode(res.body);

    return todo;
  }

  Future<Todo> updateByID(Todo updateTodo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/' + updateTodo.id;
    var body = json
        .encode({"text": updateTodo.text, "completed": !updateTodo.completed});

    String token = prefs.getString('x-auth');
    var res = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
      body: body,
    );
    return Todo.fromJson(json.decode(res.body));
  }
}
