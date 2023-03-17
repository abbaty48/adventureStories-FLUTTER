import 'package:adventure_stories/models/user_model.dart';

class Comment {
  final String? id;
  final String? commentText;
  final List<User>? likes;
  final User? user;

  Comment({this.id, this.commentText, this.user, this.likes});
}
