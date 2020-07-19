import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import 'todolist_viewmodel.dart';
import '../login/login_view.dart';

class TodolistScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => TodolistScreen());

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ValueNotifier<User>>(context, listen: false).value;

    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatar),
        ),
        title: Text(user.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.highlight_off, // highlight_off, touch_app
                color: Colors.red,
                size: 40),
            onPressed: () {
              Provider.of<ValueNotifier<User>>(context, listen: false).value =
                  null;
              Navigator.pushReplacement(
                context,
                LoginScreen.route(),
              );
            },
          ),
        ],
      ),
      body: Selector<TodolistViewmodel, int>(
        selector: (_, todoListNotifier) => todoListNotifier.todos?.length,
        builder: (context, _, __) {
          print('-' * 20);

          final todoListNotifier =
              Provider.of<TodolistViewmodel>(context, listen: false);
          final todos = todoListNotifier?.todos;
          if (todos == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.blueGrey,
            ),
            itemBuilder: (context, index) {
              return Selector<TodolistViewmodel, bool>(
                selector: (_, todoListNotifier) =>
                    todoListNotifier.todos[index].completed,
                builder: (_, __, ___) {
                  final todo =
                      Provider.of<TodolistViewmodel>(context, listen: false)
                          .todos[index];

                  // To show which ListTile gets rebuilt
                  print('Build ListTile ${index + 1}');

                  return ListTile(
                    title: Text(todo.title,
                        style: TextStyle(
                            decoration: todo.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                    subtitle: Text('id:  ${todo.id}'),
                    onTap: () => todoListNotifier.toggleTodoStatus(index),
                    onLongPress: () => todoListNotifier.removeTodo(index),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Provider.of<TodolistViewmodel>(context, listen: false).addNewTodo(),
      ),
    );
  }
}
