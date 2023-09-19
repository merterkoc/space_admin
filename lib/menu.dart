import 'package:flutter/material.dart';

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
                    SizedBox(
                      height: 20 * 3,
                    ),
                    Image.asset(
                      "asset/logo.png",
                      scale: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Space Admin")
                  ],
                )),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "asset/icons/menu_dashbord.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Posts",
              svgSrc: "asset/icons/menu_tran.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Pages",
              svgSrc: "asset/icons/menu_task.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Categories",
              svgSrc: "asset/icons/menu_doc.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Appearance",
              svgSrc: "asset/icons/menu_store.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Users",
              svgSrc: "asset/icons/menu_notification.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Tools",
              svgSrc: "asset/icons/menu_profile.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "asset/icons/menu_setting.svg",
              press: () {},
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
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}