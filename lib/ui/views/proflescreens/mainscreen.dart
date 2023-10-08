import 'package:chatapp/constants/size.dart';
import 'package:chatapp/ui/widgets/authwidget/topcontainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthScreenTop(
        height: SizeConfig.screenHeight(context) * 0.25,
        title: "Welcome",
        subtitle: "Welcome to ChatApp",
      )
    );
  }
}