import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/ui/views/tab%20views/callscreen.dart';
import 'package:chatapp/ui/views/tab%20views/chattab.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    // Adjust the length to 3, one for ChatScreen, one for CallScreen, and one for ContactScreen
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> tabViews() {
    return [
      ContactScreen(), // Add ContactScreen here
      ChatScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          leadingWidth: double.infinity,
          leading: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight(context) * 0.2,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, top: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight(context) * 0.065,
                          decoration: BoxDecoration(
                            color: AppColors.textcolor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.buttonColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Search...',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.search, size: 30),
                                  onPressed: () {
                                    // Handle search button press
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        TabBar(
                          controller: _controller,
                          indicatorColor:
                              const Color.fromARGB(255, 37, 192, 206),
                          labelColor: const Color.fromARGB(255, 255, 255, 255),
                          unselectedLabelColor: Colors.black54,
                          tabs: const [
                            Tab(
                              child: Text("Contacts",
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Tab(
                              child:
                                  Text("Chats", style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: tabViews(),
        ),
      ),
    );
  }
}
