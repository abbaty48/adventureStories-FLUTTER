import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  final List<Widget> children;
  const ToolBar({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ));
  }
}
