import 'package:flutter/material.dart';
import 'package:adventure_stories/widgets/card_box.dart';
import 'package:adventure_stories/widgets/layouts/top_bar.dart';

class AddStory extends StatefulWidget {
  const AddStory({super.key});

  @override
  State<AddStory> createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(140),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TopBar())),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Wrap(
                children: const [
                  CardBox(
                    // title
                    headerChild: Text('Card Header'),
                    // Body
                    body: Text('Card Body'),
                  ),
                ],
              ),
            )));
  }
}
