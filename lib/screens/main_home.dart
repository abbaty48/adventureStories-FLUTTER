import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/widgets/storyboard.dart';
import 'package:adventure_stories/widgets/layouts/menus.dart';
import 'package:adventure_stories/widgets/layouts/top_bar.dart';
import 'package:adventure_stories/widgets/layouts/bottom_tab.dart';

class MainHome extends RecoilWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: const [TopBar(), MenuBar()]))),
        body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10), child: StoryBoard()),
        persistentFooterButtons: const [BottomTab()]);
  }
}
