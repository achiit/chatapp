import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/data/providers/auth_provider.dart';
import 'package:chatapp/navigationviewmodel.dart';
import 'package:chatapp/ui/views/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
   
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.buttonColor),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
