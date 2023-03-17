import 'package:adventure_stories/models/story_model.dart';
import 'package:flutter/material.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/widgets/skeleton.dart';

class MidiStory extends StatelessWidget {
  final Story story;

  const MidiStory({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        dense: true,
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: Theme.of(context).backgroundColor))),
          child: Text(story.title!),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // image
            ClipRRect(
                borderRadius:
                    const BorderRadius.only(bottomLeft: Radius.circular(15)),
                child: Image.network(
                  story.image!,
                  color: Theme.of(context).hintColor,
                  height: 140,
                  width: 130,
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event-Kind-Duration-
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(child: Text(story.event!)),
                              Flexible(child: Text(story.kind.toString())),
                              Flexible(child: Text(story.duration!)),
                              Flexible(
                                  child: Skeleton(
                                      width: randomSize(0),
                                      height: 16,
                                      color: Theme.of(context).hintColor)),
                            ])),

                    const SizedBox(height: 10),
                    // Caption
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(story.stories![0].description!),
                    ),
                    const SizedBox(height: 10),

                    //Comment Likes Stories
                    Wrap(spacing: 10, children: [
                      Skeleton(
                          width: 50,
                          height: 16,
                          color: Theme.of(context).hintColor),
                      Skeleton(
                          width: 50,
                          height: 16,
                          color: Theme.of(context).hintColor),
                      Skeleton(
                          width: 50,
                          height: 16,
                          color: Theme.of(context).hintColor),
                    ]),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
