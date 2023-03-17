import 'story_skeleton.dart';
import 'package:flutter/material.dart';
import '../commons/generic_scroll_behavior.dart';

class StoryBoardSkeleton extends StatelessWidget {
  const StoryBoardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: GenericScrollBehavior(),
        child: ListView.builder(
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const StorySkeleton()));
  }
}
