import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../app/router.dart' as router;

class LoginScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a user to login as'),
      ),
      body: Consumer<List<User>>(
        builder: (context, users, _) {
          if (users == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.blueGrey,
            ),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('user id:  ${user.id}'),
                onTap: () {
                  final notifier =
                      Provider.of<ValueNotifier<User>>(context, listen: false);
                  notifier.value = user;
                  Navigator.pushReplacementNamed(context, router.todolistRoute);
                },
              );
            },
          );
        },
      ),
    );
  }
}
