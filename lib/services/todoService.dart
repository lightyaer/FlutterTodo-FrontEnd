import 'package:http/http.dart' as http;
import 'dart:convert';
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

    final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
    List<Todo> todoList =
        parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
    return todoList;
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
    todo = json.decode(res.body);
    return todo;
  }

  Future<Todo> createTodo(Todo todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/';
    var body = json.encode(todo);
    Todo createdTodo;

    String token = prefs.getString('x-auth');
    var res = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
      body: body,
    );
    createdTodo = json.decode(res.body);

    return createdTodo;
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

  Future<Todo> updateByID(String id, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString("server-url");
    String url = server + '/todos/' + id;
    Todo todo = new Todo(text: text);
    var body = json.encode(todo);

    String token = prefs.getString('x-auth');
    var res = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-auth": token,
      },
      body: body,
    );
    todo = json.decode(res.body);

    return todo;
  }
}
