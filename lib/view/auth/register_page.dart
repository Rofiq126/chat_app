import 'package:chat_app/view/component/my_button.dart';
import 'package:chat_app/view/component/my_textfield.dart';
import 'package:chat_app/view_model/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final VoidCallback onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<ChatProvider>(
        builder: (context, provider, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Let\'s create an account for you!',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                hintText: 'Email',
                controller: emailController,
                obsecure: false,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obsecure: true,
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordConfirmationController,
                hintText: 'Confirm Password',
                obsecure: true,
              ),
              const SizedBox(
                height: 25,
              ),
              MyButton(
                onTap: () {
                  provider.register(
                      email: emailController.text,
                      password: passwordController.text,
                      confirmPassword: passwordConfirmationController.text,
                      context: context);
                },
                textButton: 'Register',
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      ' Login now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
