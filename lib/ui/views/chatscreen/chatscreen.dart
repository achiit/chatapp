import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/data/models/chatmodel.dart';
import 'package:chatapp/data/models/chatscreenmodel.dart';
import 'package:chatapp/ui/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatItem chatItem;

  ChatDetailScreen({required this.chatItem});
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with WidgetsBindingObserver {
  TextEditingController _messageController = TextEditingController();
  List<ChatScreenItem> chatList = List.from(dummyChatList);
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final isKeyboardOpen =
        WidgetsBinding.instance!.window.viewInsets.bottom > 0;
    if (isKeyboardOpen) {
      // Delay the scroll to allow time for the keyboard to open
      Future.delayed(Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        leadingWidth: 40,
        backgroundColor:
            AppColors.buttonColor, // Set the background color to green
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), // Rounded bottom left corner
            bottomRight: Radius.circular(20), // Rounded bottom right corner
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              child: Text(widget.chatItem.name[0]),
            ),
            SizedBox(width: 10),
            Text(
              widget.chatItem.name,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Option 1'),
                ),
                PopupMenuItem(
                  child: Text('Option 2'),
                ),
                PopupMenuItem(
                  child: Text('Option 3'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/splashscreen.png"),
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return Bubble(chatItem: chatList[index]);
                      },
                    ),
                  ),
                  _buildMessageInput(),
                  SizedBox(height: 1.5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: Colors.white, // Background color for the input area
          borderRadius: BorderRadius.circular(25.0), // Rounded border
          border: Border.all(color: Colors.grey, width: 1.0), // Black border
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Stack(
            children: [
              TextField(
                onChanged: (text) {
                  // Handle text input changes
                },
                controller: _messageController,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    right: 42,
                    left: 26,
                    top: 18,
                  ),
                  hintText: 'Message...',
                  hintStyle: GoogleFonts.poppins(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 2,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.buttonColor,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.white,
                    onPressed: _sendMessage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      // Add the new message to the chat list
      setState(() {
        chatList.add(ChatScreenItem(message: message, isMe: true));
      });

      // Clear the message input field
      _messageController.clear();
    }
  }
}

List<ChatScreenItem> dummyChatList = [
  ChatScreenItem(message: "Hello!", isMe: false),
  ChatScreenItem(message: "Hi there!", isMe: true),
  ChatScreenItem(message: "How are you?", isMe: true),
  ChatScreenItem(message: "I'm good, thanks!", isMe: false),
  ChatScreenItem(message: "What have you been up to?", isMe: true),
  ChatScreenItem(message: "Not much, just working.", isMe: false),
  ChatScreenItem(message: "That sounds busy!", isMe: true),
  ChatScreenItem(message: "Yes, it is. How about you?", isMe: false),
];
