import 'package:chatapp/data/models/chatscreenmodel.dart';
import 'package:chatapp/ui/views/chatscreen/chatscreen.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final ChatScreenItem chatItem;

  Bubble({required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatItem.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: chatItem.isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          chatItem.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
