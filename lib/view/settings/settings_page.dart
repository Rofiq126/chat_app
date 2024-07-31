import 'package:chat_app/view_model/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.tertiary,
            )),
        title: const Text('Settings'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, provider, child) => Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dark Mode'),
              CupertinoSwitch(
                  value: provider.isDarkMode,
                  onChanged: (value) => provider.toggleTheme())
            ],
          ),
        ),
      ),
    );
  }
}
