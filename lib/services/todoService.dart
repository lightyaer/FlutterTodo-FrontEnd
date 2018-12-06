import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_frontend/models/todo.dart';

class TodoService {
  Future<List<Todo>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/todos';
    List<Todo> todos;
    try {
      String token = prefs.getString('x-auth');
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-auth": token,
        },
      );
      todos = json.decode(res.body);
    } catch (e) {
      return todos;
    }

    return todos;
  }

  Future<Todo> getByID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/todos/' + id;
    Todo todo;
    try {
      String token = prefs.getString('x-auth');
      var res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-auth": token,
        },
      );
      todo = json.decode(res.body);
    } catch (e) {
      return todo;
    }

    return todo;
  }

  Future<Todo> createTodo(Todo todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/todos/';
    var body = json.encode(todo);
    Todo createdTodo;
    try {
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
    } catch (e) {
      return createdTodo;
    }

    return createdTodo;
  }

  Future<Todo> deleteByID(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/todos/' + id;
    Todo todo;
    try {
      String token = prefs.getString('x-auth');
      var res = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "x-auth": token,
        },
      );
      todo = json.decode(res.body);
    } catch (e) {
      return todo;
    }

    return todo;
  }

  Future<Todo> updateByID(String id, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = 'http://10.0.2.2:3000/todos/' + id;
    Todo todo = new Todo(text: text);
    var body = json.encode(todo);
    try {
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
    } catch (e) {
      return todo;
    }

    return todo;
  }
}
