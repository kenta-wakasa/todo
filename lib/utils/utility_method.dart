import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> pushPage({required BuildContext context, required Widget page}) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ),
  );
}

/// Googleサインイン。成功するとtrueを返す。
Future<bool> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return false;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    return true;
  } catch (e) {
    log('$e');
    return false;
  }
}

String get uid => FirebaseAuth.instance.currentUser!.uid;

CollectionReference<Map<String, dynamic>> get tasksReference =>
    FirebaseFirestore.instance.collection('users').doc(uid).collection('tasks');
