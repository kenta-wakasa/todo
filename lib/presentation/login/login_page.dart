import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:todo/presentation/login/login_model.dart';
import 'package:todo/presentation/main/main_page.dart';
import 'package:todo/utils/utility_method.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(),
      child: Consumer<LoginModel>(
        builder: (_, model, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('ログイン'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                    buttonType: ButtonType.google,
                    onPressed: () async {
                      await model.login();
                      pushPage(
                        context: context,
                        page: const MainPage(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
