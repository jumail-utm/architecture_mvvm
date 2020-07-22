import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view.dart';
import 'todolist_viewmodel.dart';
import '../login/login_viewmodel.dart';
import '../../app/router.dart' as router;
import '../../app/dependencies.dart';

class TodolistScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => TodolistScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SelectorView<TodolistViewmodel, int>(
        initViewmodel: (todolistViewmodel) =>
            todolistViewmodel.user = dependency<LoginViewmodel>().user,
        selector: (_, todolistViewmodel) =>
            todolistViewmodel.busy ? 0 : todolistViewmodel.todos.length,
        builder: (context, todolistViewmodel, __) {
          print('-' * 20);

          final todos = todolistViewmodel.todos;

          return ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.blueGrey,
            ),
            itemBuilder: (context, index) {
              return Selector<TodolistViewmodel, bool>(
                selector: (_, todolistViewmodel) => todolistViewmodel.busy
                    ? null
                    : todolistViewmodel.todos[index].completed,
                builder: (_, __, ___) {
                  final todo = dependency<TodolistViewmodel>().todos[index];

                  // To show which ListTile gets rebuilt
                  print('Build ListTile ${index + 1} - ${todo.completed}');

                  return ListTile(
                    title: Text(todo.title,
                        style: TextStyle(
                            decoration: todo.completed
                                ? TextDecoration.lineThrough
                                : TextDecoration.none)),
                    subtitle: Text('id:  ${todo.id}'),
                    onTap: () => todolistViewmodel.toggleTodoStatus(index),
                    onLongPress: () => todolistViewmodel.removeTodo(index),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => dependency<TodolistViewmodel>().addNewTodo(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: WidgetView<LoginViewmodel>(
            builder: (_, viewmodel, __) => AppBar(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(viewmodel.user.avatar),
                  ),
                  title: Text(viewmodel.user.name),
                  actions: <Widget>[
                    IconButton(
                      icon:
                          Icon(Icons.highlight_off, // highlight_off, touch_app
                              color: Colors.red,
                              size: 40),
                      onPressed: () {
                        viewmodel.selectUser(null);
                        Navigator.pushReplacementNamed(
                          context,
                          router.loginRoute,
                        );
                      },
                    ),
                  ],
                )));
  }
}
