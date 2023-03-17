import 'package:adventure_stories/widgets/layouts/menus.dart';
import 'package:flutter/material.dart';
import 'package:adventure_stories/widgets/layouts/top_bar.dart';
import 'package:adventure_stories/widgets/layouts/bottom_tab.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: const [TopBar(), MenuBar()]))),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text('User Account')),
        persistentFooterButtons: const [BottomTab()]);
  }
}
