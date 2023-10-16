
import 'package:chatapp/data/models/chatmodel.dart';
import 'package:chatapp/ui/views/chatscreen/chatscreen.dart';
import 'package:chatapp/ui/widgets/chatitems.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final List<ChatItem> chatItems = [
    ChatItem("John", "Hello", "10:30 AM"),
    ChatItem("Alice", "Hi there!", "11:15 AM"),
    ChatItem("Bob", "Hey, how are you?", "12:00 PM"),
    // Add more ChatItems as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatItems.length,
        itemBuilder: (context, index) {
          return ChatListItem(
            chatItem: chatItems[index],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatDetailScreen(chatItem: chatItems[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
