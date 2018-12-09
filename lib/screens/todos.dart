import 'package:flutter/material.dart';

import 'package:todo_app_frontend/UI/alert.dart';
import 'package:todo_app_frontend/models/todo.dart';
import 'package:todo_app_frontend/screens/login.dart';
import 'package:todo_app_frontend/services/todoService.dart';
import 'package:todo_app_frontend/services/userService.dart';

class TodoScreen extends StatefulWidget {
  final email;
  TodoScreen({@required this.email});

  @override
  State<StatefulWidget> createState() {
    return TodoScreenState();
  }
}

class TodoScreenState extends State<TodoScreen> {
  final todoController = TextEditingController();
  Future<List<Todo>> todos;
  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todo = TextField(
      autocorrect: true,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
      ),
    );

    final drawer = Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "Welcome, \n${widget.email.toString().trim()}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("Logout"),
            onTap: () {
              Future<bool> res = UserService().logout();

              res.then((onValue) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }).catchError((onError) {
                Alert().showInfoAlert(context, "Error", onError);
              });
            },
          )
        ],
      ),
    );

    final todoList = FutureBuilder<List<Todo>>(
      future: TodoService().getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return TodoList(
            todos: snapshot.data,
          );
        }
      },
    );

    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: Text("Todo's"),
        elevation: 4.0,
      ),
      body: Column(
        children: <Widget>[
          todo,
          SizedBox(height: 5.0),
          todoList,
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  TodoList({Key key, this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].text),
          );
        },
      ),
    );
  }
}
