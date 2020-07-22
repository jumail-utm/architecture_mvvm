import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/dependencies.dart' as di;
import 'app/router.dart' as router;
import 'services/user/user_service.dart';
import 'models/user.dart';
import 'screens/todolist/todolist_viewmodel.dart';
import 'screens/login/login_viewmodel.dart';

void main() {
  di.init();

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<List<User>>(
            create: (_) => di.dependency<UserService>().getUserList()),
        ChangeNotifierProvider.value(
          value: di.dependency<LoginViewmodel>(),
        ),
        ChangeNotifierProxyProvider<LoginViewmodel, TodolistViewmodel>(
            create: (_) => di.dependency<TodolistViewmodel>(),
            update: (_, loginViewmodel, todolistViewmodel) =>
                todolistViewmodel..user = loginViewmodel.user),
      ],
      child: MaterialApp(
        title: 'MVVM Setup',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: router.loginRoute,
        onGenerateRoute: router.createRoute,
      ),
    ),
  );
}
