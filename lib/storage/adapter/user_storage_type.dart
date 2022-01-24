import 'package:hive/hive.dart';

part 'user_storage_type.g.dart';

@HiveType(typeId: 1)
class UserStorageType {
  @HiveField(0)
  int uid;

  @HiveField(1)
  int age;

  @HiveField(2)
  String name;

  @HiveField(3)
  bool? isMarried;

  @HiveField(4)
  bool isCheck;

  UserStorageType({
    required this.uid,
    required this.age,
    required this.name,
    this.isMarried,
    required this.isCheck,
  });
}
