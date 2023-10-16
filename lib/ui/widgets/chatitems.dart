import 'package:chatapp/data/models/chatmodel.dart';
import 'package:flutter/material.dart';


class ChatListItem extends StatelessWidget {
  final ChatItem chatItem;
  final VoidCallback onPressed;

  ChatListItem({required this.chatItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(chatItem.name[0]),
      ),
      title: Text(chatItem.name),
      subtitle: Text(chatItem.message),
      trailing: Text(chatItem.time),
      onTap: onPressed,
    );
  }
}