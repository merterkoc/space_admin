import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      scale: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Space Admin")
                  ],
                )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                context.go('/home');
              },
            ),
            DrawerListTile(
              title: "Astronomic Events",
              svgSrc: "asset/icons/menu_tran.svg",
              press: () {
                context.go('/astronomic-event');
              },
            ),
            DrawerListTile(
              title: "Pages",
              svgSrc: "asset/icons/menu_task.svg",
              press: () {
                context.go('/test-page');
              },
            ),

          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,

      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}