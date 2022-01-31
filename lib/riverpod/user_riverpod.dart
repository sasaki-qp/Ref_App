import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_demo_app/helper/database.dart';
import 'package:hive_demo_app/helper/global_context.dart';
import 'package:hive_demo_app/helper/lazy_test.dart';
import 'package:hive_demo_app/model/user.dart';
import 'package:hive_demo_app/screens/confirm_screen.dart';
import 'package:hive_demo_app/screens/list_screen.dart';
import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';
import 'package:hive_demo_app/storage/user_storage.dart';

final userRiverpod =
    StateNotifierProvider.autoDispose<UserStateNotifier, List<User>>(
  (ref) => UserStateNotifier(),
);

class UserStateNotifier extends StateNotifier<List<User>> {
  final getit = GetIt.I;
  late List<UserStorageType> customUsers;
  late Database db;
  late UserStorage userStorage;

  UserStateNotifier() : super([]) {
    db = getit.get<Database>();
    userStorage = getit.get<UserStorage>();
  }

  void displayUsers() {
    List<User> users = db.createUsers();
    List<int> selectedUserIds = userStorage.getAllUserIds();
    users.asMap().forEach((int key, User user) {
      if (selectedUserIds.contains(user.uid)) {
        users[key] = user.copyWith(isCheck: true);
      }
    });
    state = List.from(users);
  }

  void filterDisplayUsers() {
    if (state.every((elm) => elm.isCheck)) return;
    state.removeWhere((elm) => !elm.isCheck);
    state = List.from(state);
  }

  void selectHandler({
    required int index,
    required User user,
  }) {
    final UserStorageType input =
        UserStorageType(uid: user.uid, age: user.age, name: user.name);

    user.isCheck
        ? userStorage.removeUser(user: input)
        : userStorage.writeUser(user: input);

    state[index] = state[index].copyWith(isCheck: !state[index].isCheck);
    state = List.from(state);
  }

  void pushScreen() {
    Navigator.pushAndRemoveUntil(
      globalContext,
      MaterialPageRoute(
        builder: (_) => ConfirmScreen(),
      ),
      (_) => false,
    );
  }

  void backScreen() {
    getit.get<LazyTest>();
    Navigator.pushAndRemoveUntil(
      globalContext,
      MaterialPageRoute(
        builder: (_) => ListScreen(),
      ),
      (_) => false,
    );
  }
}
