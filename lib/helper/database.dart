import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';

class Database {
  List<UserStorageType> users = [];

  Database() {
    print("DEBUG: register singleton == Constant ");
    for (var i = 1; i <= 10; i++) {
      users.add(
        UserStorageType(
          uid: i,
          age: i * 10,
          name: "test$iさん",
          isMarried: i % 2 == 0 ? true : false,
          isCheck: false,
        ),
      );
    }
  }
}
