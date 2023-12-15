import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:space_admin/core/dio/dio_client.dart';
import 'package:space_admin/core/router/space_router/space_router.dart';
import 'package:space_admin/core/storage/secure_storage.dart';
import 'package:space_admin/global/bloc/bloc_provider.dart';

Future<void> main() async {
  bootstrapEngine();
  await initApp();
  runApp(const SpaceApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await secureTokenStorage.initialize();
  dioClient;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
}

/// create web page
class SpaceApp extends StatelessWidget {
  const SpaceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var bgColor = const Color(0xFF1E1E1E);
    var greenColor = const Color(0xFF00B87C);
    var secondaryColor = const Color(0xFF2D2D2D);
    return GlobalBlocProvider(
      child: MaterialApp.router(
        routerConfig: SpaceRouter().router,
        debugShowCheckedModeBanner: false,
        title: 'Smart Dashboard - Admin Panel v0.1 ',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: bgColor),
          scaffoldBackgroundColor: bgColor,
          primaryColor: greenColor,
          dialogBackgroundColor: secondaryColor,
          canvasColor: secondaryColor,
        ),
      ),
    );
  }
}
