import 'package:adventure_stories/models/user_model.dart';

class CardModel {
  final String? id, title, event, image;
  final User? user;
  final CardLike? likes;

  CardModel(
      {this.id, this.title, this.event, this.image, this.user, this.likes});

  CardModel toCard(dynamic result) {
    return CardModel(
        id: result?['id'],
        title: result?['title'],
        event: result?['event'],
        image: result?['image'],
        likes: result?['likes'],
        user: result?['user']);
  }

  Map<String, dynamic> toMap(CardModel card) {
    return <String, dynamic>{
      'id': card.id,
      'title': card.title,
      'event': card.event,
      'image': card.image,
      'likes': card.likes,
      'user': card.user
    };
  }
}

class CardLike {
  late String picture;
}
