import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/dependencies.dart';
import 'login_viewmodel.dart';
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
      body: ChangeNotifierProvider.value(
        value: dependency<LoginViewmodel>()..getUserList(),
        child: Consumer<LoginViewmodel>(
          builder: (context, viewmodel, _) {
            final users = viewmodel.users;

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
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text(user.name),
                  subtitle: Text('user id:  ${user.id}'),
                  onTap: () {
                    viewmodel.selectUser(index);
                    Navigator.pushReplacementNamed(
                        context, router.todolistRoute);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
