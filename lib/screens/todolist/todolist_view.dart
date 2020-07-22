import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: ChangeNotifierProvider.value(
        value: dependency<TodolistViewmodel>()
          ..user = dependency<LoginViewmodel>().user,
        child: Consumer<TodolistViewmodel>(
          builder: (context, todolistViewmodel, __) {
            print('-' * 20);

            final todos = todolistViewmodel?.todos;
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
                  selector: (_, todolistViewmodel) =>
                      todolistViewmodel.todos[index].completed,
                  builder: (_, __, ___) {
                    final todo = dependency<TodolistViewmodel>().todos[index];

                    // To show which ListTile gets rebuilt
                    print('Build ListTile ${index + 1}');

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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => dependency<TodolistViewmodel>().addNewTodo(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final user = dependency<LoginViewmodel>().user;

    return AppBar(
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
            dependency<LoginViewmodel>().selectUser(null);
            Navigator.pushReplacementNamed(
              context,
              router.loginRoute,
            );
          },
        ),
      ],
    );
  }
}
