import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/dependencies.dart' as di;
import 'app/router.dart' as router;
import 'services/user/user_service.dart';
import 'models/user.dart';
import 'screens/todolist/todolist_viewmodel.dart';

void main() {
  di.init();

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<List<User>>(
            create: (_) => di.dependency<UserService>().getUserList()),
        ChangeNotifierProvider<ValueNotifier<User>>(
          create: (_) => ValueNotifier<User>(null),
        ),
        ChangeNotifierProxyProvider<ValueNotifier<User>, TodolistViewmodel>(
            create: (_) => TodolistViewmodel(),
            update: (_, userNotifier, todoListNotifier) =>
                todoListNotifier..user = userNotifier.value),
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
