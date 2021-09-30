import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/presentation/add_task/add_task_page.dart';
import 'package:todo/presentation/login/login_page.dart';
import 'package:todo/presentation/main/main_model.dart';
import 'package:todo/utils/utility_method.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (context) {
        return MainModel();
      },
      child: Consumer<MainModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('TODOアプリ'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      await model.logout();
                      pushPage(
                        context: context,
                        page: const LoginPage(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                    ),
                    child: const Text('ログアウト'),
                  ),
                )
              ],
            ),
            body: ListView(
              children: model.taskList
                  .map(
                    (doc) => Dismissible(
                      key: ValueKey<String>(doc.id),
                      child: ListTile(
                        title: Text(doc['name']),
                      ),
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) async {
                        model.taskList.remove(doc);
                        await doc.reference.delete();
                      },
                    ),
                  )
                  .toList(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await pushPage(
                  context: context,
                  page: const AddTaskPage(),
                );
                // こうするとタスク追加ページから帰ってきたタイミングで、タスクの全件取得を呼べる。
                await model.fetchTaskList();
              },
              child: const Icon(Icons.edit),
            ),
          );
        },
      ),
    );
  }
}
