import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/utility_method.dart';

class AddTaskModel with ChangeNotifier {
  final controller = TextEditingController();

  Future<void> addTask() async {
    final name = controller.text;
    await tasksReference.add(
      <String, dynamic>{
        'name': name,
        'createAt': Timestamp.now(),
      },
    );
  }
}
