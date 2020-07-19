import 'package:flutter/foundation.dart';
import '../../app/dependencies.dart';

import '../../services/todo/todo_service.dart';
import '../../models/todo.dart';
import '../../models/user.dart';

// The todo list is user-specific
class TodolistViewmodel extends ChangeNotifier {
  List<Todo> todos;
  User _user;

  User get user => _user;
  set user(User user) {
    _user = user;
    getList();
  }

  TodolistViewmodel();
  TodoService get dataService => dependency();

  Future<void> getList() async {
    if (user == null) return;
    todos = await dataService.getUserTodoList(userId: user.id);
    notifyListeners();
  }

  Future<void> addNewTodo() async {
    final newTodo = await dataService.createTodo(
        todo: Todo(title: 'New task', userId: user.id));
    todos.add(newTodo);
    notifyListeners();
  }

  Future<void> removeTodo(int index) async {
    await dataService.deleteTodo(id: todos[index].id);
    todos.removeAt(index);
    notifyListeners();
  }

  Future<void> toggleTodoStatus(int index) async {
    final updatedTodo = await dataService.updateTodoStatus(
        id: todos[index].id, status: !todos[index].completed);
    todos[index].completed = updatedTodo.completed;
    notifyListeners();
  }
}
