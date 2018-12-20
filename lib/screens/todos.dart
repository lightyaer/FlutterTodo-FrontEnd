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

  void _saveTodo() {
    Future<Todo> savedTodo =
        TodoService().createTodo(Todo(text: todoController.text));
    savedTodo.then((onValue) => setState(() {
          todoController.clear();
        }));
  }

  void _updateTodo(Todo todo) {
    print(todo.completed);
    print(todo.text);
    Future<Todo> updatedTodo = TodoService().updateByID(todo);
    updatedTodo.then((onValue) => setState(() {}));
  }

  Future<List<Todo>> _getAllTodos() {
    return TodoService().getAll();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saveButton = Expanded(
      child: RaisedButton(
        onPressed: () {
          _saveTodo();
        },
        child: Text("Save"),
      ),
      flex: 0,
    );

    final todo = Expanded(
      child: TextField(
        controller: todoController,
        autocorrect: true,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
        ),
      ),
      flex: 1,
    );

    final todoInput = Padding(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Row(
        children: <Widget>[
          todo,
          SizedBox(
            width: 20.0,
          ),
          saveButton,
        ],
        mainAxisAlignment: MainAxisAlignment.start,
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
      future: _getAllTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return TodoList(
            todos: snapshot.data,
            updateCallback: _updateTodo,
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
          todoInput,
          SizedBox(height: 5.0),
          todoList,
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final UpdateCallback updateCallback;
  TodoList({Key key, this.todos, this.updateCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].text),
            leading: Checkbox(
              value: todos[index].completed,
              onChanged: (value) => updateCallback(todos[index]),
              tristate: false,
              activeColor: Colors.blueAccent,
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          );
        },
      ),
    );
  }
}

typedef UpdateCallback = void Function(Todo todo);
