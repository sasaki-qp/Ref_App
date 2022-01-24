// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_demo_app/riverpod/user_riverpod.dart';
import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';

class ConfirmScreen extends ConsumerWidget {
  late List<UserStorageType> state;
  late UserStateNotifier notifier;
  @override
  build(BuildContext context, ScopedReader watch) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      notifier.filterDisplayUsers();
    });
    state = watch(userRiverpod);
    notifier = watch(userRiverpod.notifier);
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
