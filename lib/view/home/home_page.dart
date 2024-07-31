import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/view/chat/chat_page.dart';
import 'package:chat_app/view/component/my_drawer.dart';
import 'package:chat_app/view/component/my_loading.dart';
import 'package:chat_app/view/component/user_tile.dart';
import 'package:chat_app/view_model/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: buildListUser(),
        drawer: MyDrawer(
          provider: provider,
        ),
      ),
    );
  }

  Widget buildListUser() {
    return StreamBuilder(
        stream: chatService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error...');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoading();
          } else if (snapshot.data == null) {
            return const Text('Data Empty..');
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                  children: snapshot.data!
                      .map<Widget>((userData) => buildUserListItem(
                          userData: userData, context: context))
                      .toList()),
            );
          }
        });
  }

  Widget buildUserListItem(
      {required Map<String, dynamic> userData, required BuildContext context}) {
    if (userData["email"] != AuthService().auth.currentUser!.email) {
      return UserTile(
          text: userData["email"],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatPage(
                          text: userData["email"],
                          receiverId: userData["uid"],
                          receiverEmail: userData["email"],
                        )));
          });
    } else {
      return Container();
    }
  }
}
