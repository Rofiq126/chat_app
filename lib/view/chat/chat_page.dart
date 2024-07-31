import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/view/component/my_loading.dart';
import 'package:chat_app/view/component/my_textfield.dart';
import 'package:chat_app/view_model/chat_provider.dart';
import 'package:chat_app/view_model/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String text;
  final String receiverId;
  final String receiverEmail;
  const ChatPage(
      {super.key,
      required this.text,
      required this.receiverEmail,
      required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FocusNode myFocusNode = FocusNode();
  ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () => scrollDown());
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.grey,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.tertiary,
              )),
          title: Text(widget.text),
        ),
        body: Column(
          children: [
            Expanded(child: buildMessageList()),
            buildUserInput(
                provider: provider,
                context: context,
                message: messageController.text,
                receiverId: widget.receiverId)
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
        stream: ChatService().getMessage(
            userId: auth.currentUser!.uid, otherUserId: widget.receiverId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Text('Data Empty');
          } else if (snapshot.hasError) {
            return const Text('Error..');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoading();
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 30),
              child: ListView(
                controller: scrollController,
                children: snapshot.data!.docs
                    .map((doc) => buildMessage(doc))
                    .toList(),
              ),
            );
          }
        });
  }

  Widget buildMessage(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == auth.currentUser!.uid;
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    Alignment alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return ChatBubble(
      elevation: 0,
      clipper: isCurrentUser
          ? ChatBubbleClipper5(type: BubbleType.sendBubble)
          : ChatBubbleClipper5(type: BubbleType.receiverBubble),
      alignment: alignment,
      margin: const EdgeInsets.only(top: 10),
      backGroundColor: isCurrentUser
          ? (isDarkMode ? Colors.green : Colors.grey.shade500)
          : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Text(
          data["message"],
          style: TextStyle(
              color: isDarkMode
                  ? Colors.white
                  : (isDarkMode ? Colors.white : Colors.black87)),
        ),
      ),
    );
  }

  Widget buildUserInput(
      {required ChatProvider provider,
      required BuildContext context,
      required String message,
      required String receiverId}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 10),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hintText: 'Type a message',
                  obsecure: false,
                  focusNode: myFocusNode,
                  controller: messageController)),
          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: IconButton(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      provider.sendMessage(
                          context: context,
                          message: messageController.text,
                          receiverId: receiverId);
                      messageController.clear();
                      scrollDown();
                    }
                  },
                  icon: Icon(
                    Icons.arrow_upward_rounded,
                    size: 25,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
