import 'package:flutter/material.dart';
import 'package:space_admin/src/home/component/menu.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key, required this.currentPage});

  final Widget currentPage;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: widget.currentPage,
          ),
        ],
      ),
    );
  }
}
