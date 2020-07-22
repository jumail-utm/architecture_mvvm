import 'package:flutter/foundation.dart';
import '../../app/dependencies.dart';

import '../../services/user/user_service.dart';
import '../../models/user.dart';

class LoginViewmodel extends ChangeNotifier {
  List<User> users;
  int _selected;
  UserService get dataService => dependency();

  void getUserList() async {
    users = await dataService.getUserList();
    _selected = null;
    notifyListeners();
  }

  User get user =>
      (users != null) && (_selected != null) ? users[_selected] : null;

  void selectUser(int index) {
    _selected = index;
    notifyListeners();
  }
}
