import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/utils/utility_method.dart';

class MainModel with ChangeNotifier {
  MainModel() {
    // ここに最初に実行したい処理を書くとよい
    fetchTaskList();
  }
  List<QueryDocumentSnapshot<Map<String, dynamic>>> taskList = [];

  Future<void> fetchTaskList() async {
    /// orderByで順番をソートできる。
    final snapshot = await tasksReference.orderBy('createAt', descending: true).get();
    taskList = snapshot.docs;
    notifyListeners();
  }

    /// ログアウト
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners(); // これを呼ぶと画面が再描画
  }
}
