import 'package:flutter/material.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/widgets/layouts/tool_bar.dart';
import 'package:adventure_stories/widgets/theme_toggle_button.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ToolBar(
      children: <Widget>[
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home_screen');
                },
                icon: Icon(
                  AdventureStories.home,
                  color: Theme.of(context).iconTheme.color,
                )),
            const ThemeToggle(),
          ],
        ),
        Row(
          children: [
            // circular avatar here:
            // NOTE: if the circleAvatar didn't works, use NetworkImage instead of Image.network
            loggedInUser == null
                ? IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login_screen');
                    },
                    icon: const Icon(AdventureStories.login))
                : CircleAvatar(
                    foregroundColor: Theme.of(context).primaryColor,
                    backgroundColor:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.1),
                    foregroundImage: Image.network(
                      loggedInUser!.picture!,
                      fit: BoxFit.cover,
                      // 'https://picsum.photos/250?image=9',
                      alignment: Alignment.center,
                      loadingBuilder: (context, child, loadingProgress) =>
                          CircularProgressIndicator(
                              strokeWidth: 0.5,
                              color: Theme.of(context)
                                  .progressIndicatorTheme
                                  .color),
                    ).image),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  AdventureStories.notifications,
                  color: Theme.of(context).iconTheme.color,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  AdventureStories.search,
                  color: Theme.of(context).iconTheme.color,
                )),
          ],
        ),
      ],
    );
  }
}
