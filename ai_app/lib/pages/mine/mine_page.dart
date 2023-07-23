import 'package:app/utils/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final GoogleAuthRepository _googleAuthRepository = GoogleAuthRepository();
  final AppleAuthRepository _appleAuthRepository = AppleAuthRepository();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              bool loginSuccess =
                  await _googleAuthRepository.signInWithGoogle();
              if (loginSuccess) {
                EasyLoading.showToast('登录成功');
              }
            },
            child: const Text('sign in google')),
        TextButton(
            onPressed: () async {
              String? token = await _appleAuthRepository.signInWithApple();
              if (token != null) {
                EasyLoading.showToast('登录成功');
              }
            },
            child: const Text('sign in apple'))
      ],
    ));
  }
}
