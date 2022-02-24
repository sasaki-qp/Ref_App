// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_demo_app/enum/enum.dart';
import 'package:hive_demo_app/extension/extension.dart';
import 'package:hive_demo_app/model/user.dart';
import 'package:hive_demo_app/riverpod/user_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListScreen extends HookConsumerWidget {
  late List<User> state;
  late UserStateNotifier notifier;
  UserOpts opts = UserOpts.MASTER;
  @override
  build(BuildContext context, WidgetRef ref) {
    notifier = ref.watch(userRiverpod.notifier);
    state = ref.watch(userRiverpod);

    useEffect(() {
      notifier.createTask();
      Future(() async {
        await Future.delayed(const Duration(seconds: 1));
        notifier.displayUsers();
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Current User Role === ${opts.role}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                itemCount: state.length,
                itemBuilder: (
                  BuildContext context,
                  int currentIndex,
                ) {
                  return InkWell(
                    onTap: () {
                      notifier.selectHandler(
                        index: currentIndex,
                        user: state[currentIndex],
                      );
                    },
                    child: ListTile(
                      title: Text(
                          "ID: ${state[currentIndex].uid}, NAME: ${state[currentIndex].name}"),
                      subtitle: Text("AGE: ${state[currentIndex].age}"),
                      leading: Checkbox(
                        value: state[currentIndex].isCheck,
                        onChanged: (_) {},
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Go to confirm screen"),
              onPressed: () {
                notifier.pushScreen();
              },
            )
          ],
        ),
      ),
    );
  }
}
