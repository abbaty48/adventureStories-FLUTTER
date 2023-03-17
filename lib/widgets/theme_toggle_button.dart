import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/commons/themes.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class ThemeToggle extends RecoilWidget {
  final bool? showLabel;

  const ThemeToggle({super.key, this.showLabel});

  @override
  Widget build(BuildContext context) {
    var themeState = useRecoilState(themeAtom);
    var isDarkMode = useRecoilState(isDarkModeAtom);

    return GestureDetector(
        onTap: () {
          if (isDarkMode.data == true) {
            themeState.setData(LightThemeMode());
            isDarkMode.setData(false);
          } else {
            themeState.setData(DarkThemeMode());
            isDarkMode.setData(true);
          }
        },
        child: Row(children: [
          Icon(
            isDarkMode.data
                ? AdventureStories.light_down
                : AdventureStories.sun_filled,
            color: Theme.of(context).iconTheme.color,
          ),
          if (showLabel != null)
            Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(isDarkMode.data ? 'light' : 'dark'))
        ]));
  }
}
