// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/view/component/my_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatProvider extends ChangeNotifier {
  bool showLogin = true;

  Future login(
      {required String email, password, required BuildContext context}) async {
    try {
      await AuthService()
          .loginWithEmailPassword(email: email, password: password);
    } catch (exception) {
      myAlertDialog(context: context, message: exception.toString());
    }
  }

  Future register(
      {required String email,
      required String password,
      required String confirmPassword,
      required BuildContext context}) async {
    try {
      if (password == confirmPassword) {
        await AuthService().register(email: email, password: password);
      } else {
        throw ('Password don\'t match!');
      }
    } catch (exception) {
      myAlertDialog(context: context, message: exception.toString());
    }
  }

  Future logout(BuildContext context) async {
    try {
      await AuthService().logout();
    } catch (exception) {
      myAlertDialog(context: context, message: exception.toString());
    }
  }

  void togglePages() {
    showLogin = !showLogin;
    notifyListeners();
  }

  Future sendMessage(
      {required String receiverId,
      required String message,
      required BuildContext context}) async {
    try {
      if (message.isNotEmpty || message != ' ') {
        await ChatService()
            .sendMessage(receiverId: receiverId, message: message);
      } else {
        throw 'Cannot send empty message!';
      }
    } catch (exception) {
      myAlertDialog(context: context, message: exception.toString());
    }
  }
}
