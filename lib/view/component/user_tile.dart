import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person_rounded),
            const SizedBox(
              width: 10,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
