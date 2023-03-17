import 'package:flutter/material.dart';
import '../commons/generic_scroll_behavior.dart';
import 'package:adventure_stories/widgets/midi_story_skeleton.dart';

class MidiStorySkeletons extends StatelessWidget {
  const MidiStorySkeletons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) => const MidiStorySkeleton(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10),
        ));
  }
}
