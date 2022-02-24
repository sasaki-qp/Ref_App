// ignore_for_file: unnecessary_this
import 'package:hive_demo_app/enum/enum.dart';

extension UserOptsExt on UserOpts {
  static final userRole = {
    UserOpts.MASTER: "MASTER",
    UserOpts.ADMIN: "ADMIN",
    UserOpts.USER: "USER",
  };

  String? get role => userRole[this];
}

class Task {
  String title;
  bool isDone;

  Task({
    required this.title,
    required this.isDone,
  });
}

extension TaskExt on String {
  Task filterIsDone() {
    return Task(
      title: this,
      isDone: this.length > 10 ? true : false,
    );
  }
}
