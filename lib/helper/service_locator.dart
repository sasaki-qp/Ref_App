import 'package:get_it/get_it.dart';
import 'package:hive_demo_app/helper/database.dart';
import 'package:hive_demo_app/helper/lazy_test.dart';
import 'package:hive_demo_app/storage/user_storage.dart';

class ServiceLocator {
  final getit = GetIt.I;

  ServiceLocator() {
    getit.registerSingleton<Database>(Database());
    getit.registerSingleton<UserStorage>(UserStorage());
    // test
    getit.registerLazySingleton(() => LazyTest());
  }
}
