import 'package:get_it/get_it.dart';

import '../services/rest_service.dart';
import '../services/todo/todo_service.dart';
import '../services/todo/todo_service_rest.dart';
import '../services/user/user_service.dart';
import '../services/user/user_service_rest.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton(() => RestService());
  dependency.registerLazySingleton<TodoService>(() => TodoServiceRest());
  dependency.registerLazySingleton<UserService>(() => UserServiceRest());
}
