import 'package:flutter/material.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/widgets/skeleton.dart';

class MidiStorySkeleton extends StatelessWidget {
  const MidiStorySkeleton({super.key});

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
          child: Skeleton(
              width: 100, height: 16, color: Theme.of(context).hintColor),
        ),
        subtitle: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // image

            Skeleton(
              color: Theme.of(context).hintColor,
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(15)),
              height: 140,
              width: 130,
            ),
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
                              Flexible(
                                  child: Skeleton(
                                      width: randomSize(0),
                                      height: 16,
                                      color: Theme.of(context).hintColor)),
                              Flexible(
                                  child: Skeleton(
                                      width: randomSize(0),
                                      height: 16,
                                      color: Theme.of(context).hintColor)),
                              Flexible(
                                  child: Skeleton(
                                      width: randomSize(0),
                                      height: 16,
                                      color: Theme.of(context).hintColor)),
                              Flexible(
                                  child: Skeleton(
                                      width: randomSize(0),
                                      height: 16,
                                      color: Theme.of(context).hintColor)),
                            ])),

                    const SizedBox(height: 10),
                    // Caption
                    Skeleton(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2,
                        // width: 100,
                        color: Theme.of(context).hintColor),
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
