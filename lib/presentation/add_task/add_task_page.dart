import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/add_task/add_task_model.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskModel(),
      child: Consumer<AddTaskModel>(
        builder: (_, model, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('やることを追加！'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.addTask();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                    ),
                    child: const Text('追加！'),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: model.controller,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
