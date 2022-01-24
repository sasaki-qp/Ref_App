import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_demo_app/helper/database.dart';
import 'package:hive_demo_app/helper/global_context.dart';
import 'package:hive_demo_app/helper/lazy_test.dart';
import 'package:hive_demo_app/screens/confirm_screen.dart';
import 'package:hive_demo_app/screens/list_screen.dart';
import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';
import 'package:hive_demo_app/storage/user_storage.dart';

final userRiverpod =
    StateNotifierProvider.autoDispose<UserStateNotifier, List<UserStorageType>>(
  (ref) => UserStateNotifier(),
);

class UserStateNotifier extends StateNotifier<List<UserStorageType>> {
  final getit = GetIt.I;
  late List<UserStorageType> customUsers;
  late Database db;
  late UserStorage userStorage;
  UserStateNotifier() : super([]) {
    db = getit.get<Database>();
    userStorage = getit.get<UserStorage>();
  }

  void filterSelectedUsers() {
    if (state.isNotEmpty && !state.every((elm) => elm.isCheck)) return;
    state = db.users.map<UserStorageType>((elm) {
      if (userStorage.getAllUserIds().contains(elm.uid)) {
        elm.isCheck = true;
      }
      return elm;
    }).toList();
  }

  void userSelectHandler({
    required int index,
    required UserStorageType user,
  }) {
    user.isCheck
        ? userStorage.removeUser(user: user)
        : userStorage.writeUser(user: user);

    state[index].isCheck = !state[index].isCheck;
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

  void filterDisplayUsers() {
    if (state.every((elm) => elm.isCheck)) return;
    state.removeWhere((elm) => !elm.isCheck);
    state = List.from(state);
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
