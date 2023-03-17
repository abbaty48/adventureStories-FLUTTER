import 'package:flutter/material.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

/* */
enum BottomTabItems { home, stories, account }

// Represent the current selected Bottom
BottomTabItems _selectedTab = BottomTabItems.home;

class _BottomTabState extends State<BottomTab> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: IconButton(
                isSelected: _selectedTab == BottomTabItems.home,
                icon: Icon(
                  AdventureStories.home,
                  color: _selectedTab == BottomTabItems.home
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).iconTheme.color,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _selectedTab = BottomTabItems.home;
                    Navigator.pushNamed(context, 'home_screen',
                        arguments: _selectedTab);
                  });
                },
              )),
          if (loggedInUser != null)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: IconButton(
                  isSelected: _selectedTab == BottomTabItems.stories,
                  icon: Icon(
                    AdventureStories.docs,
                    color: _selectedTab == BottomTabItems.stories
                        ? Theme.of(context).highlightColor
                        : Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = BottomTabItems.stories;
                      Navigator.pushNamed(context, 'stories_screen',
                          arguments: _selectedTab);
                    });
                  },
                )),
          if (loggedInUser != null)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: IconButton(
                  isSelected: _selectedTab == BottomTabItems.account,
                  icon: Icon(
                    AdventureStories.users,
                    color: _selectedTab == BottomTabItems.account
                        ? Theme.of(context).highlightColor
                        : Theme.of(context).iconTheme.color,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = BottomTabItems.account;
                      Navigator.pushNamed(context, 'account_screen',
                          arguments: _selectedTab);
                    });
                  },
                )),
        ],
      ),
    );
  }
}
