import 'package:chat_app/view/settings/settings_page.dart';
import 'package:chat_app/view_model/chat_provider.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final ChatProvider provider;
  const MyDrawer({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                child: Icon(
                  Icons.chat,
                  color: Theme.of(context).colorScheme.primary,
                  size: 70,
                ),
              )),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 25),
                onTap: () => Navigator.pop(context),
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text(
                  'H O M E',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 25),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsPage())),
                leading: Icon(
                  Icons.settings_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('S E T T I N G S',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
              ),
            ],
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 25, bottom: 25),
            onTap: () {
              provider.logout(context);
            },
            leading: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text('L O G O U T',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          )
        ],
      ),
    );
  }
}
