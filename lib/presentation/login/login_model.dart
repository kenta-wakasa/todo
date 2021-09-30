import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/utils/utility_method.dart';

class LoginModel with ChangeNotifier {

  /// ログインした上でログインしたユーザーデータをFirestoreに作成する。
  Future<void> login() async {
    final res = await signInWithGoogle();
    if (res) {
      // TODO(kenta-wakasa): 登録したユーザーデータを作る。
      final user = FirebaseAuth.instance.currentUser;

      // ここでnullチェック
      if (user == null) {
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        <String, dynamic>{
          'name': user.displayName,
          'imageUrl': user.photoURL,
          'email': user.email,
        },
      );
    }
    notifyListeners();
  }
}
