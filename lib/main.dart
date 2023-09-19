import 'dart:ui_web';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:space_admin/core/firebase/firebase_options.dart';
import 'package:space_admin/src/home/pages/home_page.dart';

Future<void> main() async {
  bootstrapEngine();
  await initApp();
  runApp(MyApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// create web page
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var bgColor = Color(0xFF1E1E1E);
    var greenColor = Color(0xFF00B87C);
    var secondaryColor = Color(0xFF2D2D2D);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Dashboard - Admin Panel v0.1 ',
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(backgroundColor: bgColor),
        scaffoldBackgroundColor: bgColor,
        primaryColor: greenColor,
        dialogBackgroundColor: secondaryColor,
        canvasColor: secondaryColor,
      ),
      home: const HomePage(),
    );
  }
}
