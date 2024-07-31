import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsecure;
  final FocusNode? focusNode;
  const MyTextField(
      {super.key,
      required this.hintText,
      this.focusNode,
      required this.obsecure,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        focusNode: focusNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.tertiary)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 14),
            fillColor: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
