class UserStory {
  late String storyID;
}

class UserFollowers {
  late String providerID;
}

class User {
  late String? name;
  late String? email;
  late String? token;
  late String? picture;
  late String? providerID;
  late List<UserStory>? stories;
  late List<UserFollowers>? followers;

  User(
      {this.name,
      this.email,
      this.token,
      this.picture,
      this.providerID,
      this.stories,
      this.followers});

  static toUser(Map? inMap) {
    return User(
      providerID: inMap?['providerID'],
      name: inMap?['name'],
      email: inMap?['email'],
      token: inMap?['token'],
      picture: inMap?['picture'],
      stories: inMap?['stories'],
      followers: inMap?['followers'],
    );
  }

  static toMap(User? inUser) {
    return <String, dynamic>{
      'providerID': inUser?.providerID,
      'name': inUser?.name,
      'email': inUser?.email,
      'picture': inUser?.picture,
      'token': inUser?.token,
      'stories': inUser?.stories,
      'followers': inUser?.followers
    };
  }

  @override
  String toString() {
    return '{providerID:$providerID, name:$name, email:$email, picture:$picture, token:$token}';
  }
}
