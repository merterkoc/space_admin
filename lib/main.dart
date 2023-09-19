import 'package:flutter/material.dart';
import 'package:space_admin/home_view.dart';

void main() {
  runApp(MyApp());
}

/// create web page
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var bgColor = Color(0xFF1E1E1E);
    var greenColor = Color(0xFF00B87C);
    var secondaryColor = Color(0xFF2D2D2D);
    var greenColor2 = Color(0xFF00B87C);
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
      home: HomePage(),
    );
  }
}
