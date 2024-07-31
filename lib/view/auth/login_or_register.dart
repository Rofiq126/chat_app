import 'package:chat_app/view/auth/login_page.dart';
import 'package:chat_app/view/auth/register_page.dart';
import 'package:chat_app/view_model/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        if (provider.showLogin) {
          return LoginPage(
            onTap: provider.togglePages,
          );
        } else {
          return RegisterPage(
            onTap: provider.togglePages,
          );
        }
      },
    );
  }
}
