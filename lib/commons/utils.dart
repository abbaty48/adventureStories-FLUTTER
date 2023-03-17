import 'dart:math';
import 'dart:convert';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// represent a global gqlClient instance of GraphqQlClient
late ValueNotifier<GraphQLClient>? gqlClient;
// represent the current loggedIn user
User? loggedInUser;
// to a global flutter-security-storage variable
late FlutterSecureStorage flutterSS;
// decode a jwt token
Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

// Random
randomSize(num maxSize, {int min = 10}) {
  return Random().nextDouble() * 100.0 + min;
}
