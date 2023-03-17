/*
    USER REPOSITORY
    ================
    AddUser
    DeleteUser
    EditUSer
    GetUser
    GetUserStories
    GetUserFollowers
 */

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/models/user_model.dart';

/// Future<User?> addUser: add a new user. if success, return a User object, else null
/// if anything goes wrong.
Future<User?> addUser(
    {required String providerID,
    required String email,
    required String name,
    required String picture}) async {
  var result = await gqlClient!.value.mutate(MutationOptions(document: gql(''' 
              mutation addMe(\$email: String!, \$name: String!, \$picture: String!, \$providerID: String!) {
                addMe(input: {email: \$email, name: \$name, picture: \$picture, providerID: \$providerID}) {
                  providerID email name picture token 
                }
              }
         '''), variables: {
    'email': email,
    'name': name,
    'picture': picture,
    'providerID': providerID
  }));

  if (result.hasException) {
    return null;
  }

  Map? addMe = result.data!['addMe'];
  return addMe != null ? User.toUser(addMe) : null;
} // end AddUser

/// Future<User?> getUser: query a user with providerID. if found, it returns the User object otherwise a null
///
/// providerID : a unique providerId of the user to search for
///
/// subTypes: an array list of the fields to project. if null, this will return all fields except stories and followers.
Future<User?> getUser(
    {required String providerID, List<String>? subTypes}) async {
  final queryString = subTypes != null
      ? subTypes.join(' ')
      : 'providerID email name picture token';

  final QueryResult result = await gqlClient!.value
      .query(QueryOptions(document: gql(''' query me(\$providerId: ID!) {
              me(providerID: \$providerId) {
                $queryString
            }
        }
        '''), variables: {'providerId': providerID}));

  if (result.hasException) {
    return null;
  }
  Map? me = result.data!['me'];
  return me == null ? null : User.toUser(me);
} // end

/// EditUser
/// Future<User>? editUser: edit a user information, and return the user data or null if anything goes wrong.
///
/// NOTE: to edit users stories, use the stories repository
///
/// NOTE: you need to provider the user's token for authentication and authorization via the authorization:Bearer header
///
/// input: an object of the user's data to update
Future<User?> editUser({String? name, token, picture}) async {
  var result = await gqlClient!.value.mutate(MutationOptions(
      document: gql(
          ''' mutation EditUser(\$name: String, \$token: String, \$picture: String) {
          editMe(input: {name: \$name, token: \$token, picture: \$picture}) {
          }
        } 
    '''),
      variables: {
        'name': name,
        'token': token,
        'picture': picture,
      }));

  if (result.hasException) {
    return null;
  }

  Map? editMe = result.data!['editMe'];
  return editMe == null ? null : User.toUser(editMe);
}

/// DeleteUser
/// Future<bool>? deleteUser: delete a user's account. return true/false for the operation, or a
/// null if any exception happen.
///
/// NOTE: you must provide the user's token via the authorization:Bearer header
Future<bool?> deleteUser() async {
  var result = await gqlClient!.value
      .mutate(MutationOptions(document: gql(''' mutation DestroyMe {
              destroyMe
            }
        ''')));

  if (result.hasException) {
    return null;
  }
  return result.data!['destroyMe'];
}
