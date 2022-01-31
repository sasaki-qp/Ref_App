import 'package:hive/hive.dart';
import 'package:hive_demo_app/model/user.dart';
import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';

class UserStorage {
  Box<UserStorageType> userBox = Hive.box<UserStorageType>('box');

  void writeUser({required UserStorageType user}) {
    userBox.put(user.uid, user);
  }

  void removeUser({required UserStorageType user}) {
    userBox.delete(user.uid);
  }

  UserStorageType? getUser({required User user}) {
    return userBox.get(user.uid);
  }

  List<int> getAllUserIds() {
    return userBox.values.toList().map<int>((elm) => elm.uid).toList();
  }
}
