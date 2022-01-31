import 'package:hive_demo_app/model/user.dart';

class Database {
  Database() {
    print("DEBUG: register singleton == Constant ");
  }

  List<User> createUsers() {
    List<User> users = [];
    for (var i = 1; i <= 10; i++) {
      users.add(User(uid: i, age: i * 10, name: 'test name: $i'));
    }
    return users;
  }
}
