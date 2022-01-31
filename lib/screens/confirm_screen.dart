// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_demo_app/model/user.dart';
import 'package:hive_demo_app/riverpod/user_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmScreen extends HookConsumerWidget {
  late List<User> state;
  late UserStateNotifier notifier;
  @override
  build(BuildContext context, WidgetRef ref) {
    state = ref.watch(userRiverpod);
    notifier = ref.watch(userRiverpod.notifier);

    useEffect(() {
      Future(() async {
        await Future.delayed(const Duration(seconds: 1));
        notifier.filterDisplayUsers();
      });
    }, []);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('confirm users'),
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
                  return ListTile(
                    title: Text(
                        "ID: ${state[currentIndex].uid}, NAME: ${state[currentIndex].name}"),
                    subtitle: Text("AGE: ${state[currentIndex].age}"),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Back to screen"),
              onPressed: () {
                notifier.backScreen();
              },
            )
          ],
        ),
      ),
    );
  }
}
