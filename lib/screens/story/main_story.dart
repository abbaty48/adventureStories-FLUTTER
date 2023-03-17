import 'package:flutter/material.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adventure_stories/widgets/midi_story.dart';
import 'package:adventure_stories/models/story_model.dart';
import 'package:adventure_stories/widgets/layouts/top_bar.dart';
import 'package:adventure_stories/screens/story/add_story.dart';
import 'package:adventure_stories/widgets/layouts/bottom_tab.dart';
import 'package:adventure_stories/widgets/midi_story_skeletons.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class MyStories extends StatelessWidget {
  const MyStories({super.key});

  @override
  Widget build(BuildContext context) {
    final addStoryWidget = Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Center(
          child: TextButton.icon(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddStory())),
            // for the icon use AdventuresStories icons, by adding the icon at fluttericons.com
            icon: Icon(Icons.post_add_rounded,
                size: 40, color: Theme.of(context).iconTheme.color),
            label: Text('Add Story',
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ),
        ));

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: TopBar()),
      body: Query(
        options: QueryOptions(document: gql(''' 
                    query MyStories(\$providerID: ID!) {
          me(providerID: \$providerID) {
                          Stories {
                            id title event difficulty kind image
            }
          }
        } 
                  '''), variables: {'providerID': loggedInUser!.providerID}),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Column(
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
                const Flexible(flex: 1, child: MidiStorySkeletons())
              ],
            );
          }

          if (result.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(
                            color: Theme.of(context)
                                .progressIndicatorTheme
                                .color))),
                const Flexible(child: MidiStorySkeletons())
              ],
            );
          }

          List? data = result.data!['me']?['Stories'];
          if (data == null) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(AdventureStories.book, size: 80),
                          SizedBox(height: 20),
                          Text('You have no stories yet!')
                        ],
                      ),
                      addStoryWidget,
                    ]));
          } // end data

          return ListView.separated(
              itemBuilder: (context, index) {
                // final Story story = Story.toStory(data[index]);
                return MidiStory(story: Story.toStory(data[index]));
              },
              separatorBuilder: (context, index) => const SizedBox(height: 30),
              itemCount: data.length);
        },
      ),
      persistentFooterButtons: const [BottomTab()],
    );
  }
}
