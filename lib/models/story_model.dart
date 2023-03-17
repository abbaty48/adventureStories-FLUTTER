import 'package:adventure_stories/models/user_model.dart';

import 'comment_model.dart';

enum STORYDIFFICULTIES { easy, medium, hard }

enum STORYKIND { single, group, family, friends, games }

class Story {
  late String? id, title, event, image, duration;
  final STORYDIFFICULTIES? difficulty;
  final STORYKIND? kind;
  final List<User>? likes;
  final User? owner;
  final List<StoryFeature>? stories;
  final List<Comment>? comments;

  Story(
      {required this.id,
      required this.title,
      required this.event,
      required this.image,
      required this.duration,
      required this.difficulty,
      required this.kind,
      required this.owner,
      required this.stories,
      this.likes,
      this.comments});

  static toStory(Map<dynamic, dynamic>? inMap) {
    return Story(
        id: inMap?['id'],
        title: inMap?['title'],
        event: inMap?['event'],
        image: inMap?['image'],
        duration: inMap?['duration'],
        difficulty: inMap?['difficulty'],
        kind: inMap?['kind'],
        owner: inMap?['owner'],
        stories: inMap?['stories']);
  }

  static Map<dynamic, dynamic> toMap(Story? inStory) {
    return <dynamic, dynamic>{
      'id': inStory?.id,
      'title': inStory?.title,
      'event': inStory?.event,
      'image': inStory?.image,
      'duration': inStory?.duration,
      'difficulty': inStory?.difficulty,
      'kind': inStory?.kind,
      'owner': inStory?.owner,
      'stories': inStory?.stories
    };
  }
}

class StoryComments {
  late int? totalComments;
  late List<Comment>? datas;
  late bool? hasNextComments;
  late bool? hasPreviousComments;
}

class StoryFeature {
  late String? caption;
  late String? description;
  late List<String>? images;
}
