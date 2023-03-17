import 'story_skeleton.dart';
import 'storyboard_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class StoryBoard extends RecoilWidget {
  const StoryBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var event = useRecoilState(selectedMenuItemAtom);

    return Query(
        options: QueryOptions(document: gql('''query Stories(\$event: String!) {
                  stories(event: \$event) {
                    id title event image
                    Likes {
                      picture
                    }
                  }
                }
          '''), variables: {'event': event.data ?? ''}),
        builder: (result, {fetchMore, refetch}) {
          // if error occured
          if (result.hasException) {
            // return StoryBoard skeleton with a message underneth
            return Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide.none,
                          right: BorderSide.none,
                          top: BorderSide.none)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text('Server error'),
                ),
                const Flexible(flex: 1, child: StoryBoardSkeleton())
              ],
            ));
          }

          if (result.isLoading) {
            // return StoryBoard skeleton and a loader show loading underneath
            return Flexible(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .progressIndicatorTheme
                                .color))),
                const Flexible(child: StoryBoardSkeleton())
              ],
            ));
          }

          List? stories = result.data?['stories'];

          if (stories!.isEmpty) {
            // return a empty dashboard
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(AdventureStories.docs,
                        size: 100, color: Theme.of(context).iconTheme.color),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text('No Stories available for ${event.data}'))
                  ],
                ));
          }
          return const Flexible(child: StorySkeleton());
          //
        });
  }
}
