// ignore_for_file: constant_identifier_names
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:adventure_stories/models/user_model.dart';
import 'package:adventure_stories/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:adventure_stories/commons/constants.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String clientID() {
  if (Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectURL() {
  if (Platform.isAndroid) {
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}

class AuthService {
  AuthService._(); // private constructor
  static AuthService instance = AuthService._();

  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  /*
    Initialization
    The first method, called by the Application in main.dart is initAuth() . 
    It checks for an existing refresh token and tries to obtain a fresh access token with it. 
    If that works, we have a logged-in user and our Application goes into the authenticated state. 
    If not, either no user has logged in yet, or the token expired. 
    In both cases, our App goes into an unauthenticated state.
  */
  Future<bool> initAuth() async {
    final String? storedRefreshToken =
        await flutterSS.read(key: REFRESH_TOKEN_KEY);
    final TokenResponse? result;

    if (storedRefreshToken == null) {
      return false;
    }

    try {
      // obtaining token response for refresh token
      result = await _appAuth.token(TokenRequest(clientID(), redirectURL(),
          issuer: GOOGLE_ISSUER, refreshToken: storedRefreshToken));
      return await _handleAuthResult(result);
    } catch (e, s) {
      print('error on refresh Token: $e - stack: $s');
      return false;
    }
  } // end future

  /*
   * 
   */
  Future<bool> login() async {
    AuthorizationTokenRequest authorizationTokenRequest;

    try {
      authorizationTokenRequest = AuthorizationTokenRequest(
          clientID(), redirectURL(),
          scopes: ['email', 'profile'], issuer: GOOGLE_ISSUER);

      final AuthorizationTokenResponse? result =
          await _appAuth.authorizeAndExchangeCode(authorizationTokenRequest);

      return _handleAuthResult(result);
    } on PlatformException {
      print('User has cancelled or no internet');
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /*
  */
  Future<bool> logout() async {
    await flutterSS.delete(key: REFRESH_TOKEN_KEY);
    return true;
  }

  /*
   * 
   */
  Future<bool> _handleAuthResult(result) async {
    final bool isValidResult =
        result != null && result.accessToken != null && result.idToken != null;

    if (isValidResult) {
      // store the new refresh token if not null
      if (result.refreshToken != null) {
        await flutterSS.write(
            key: REFRESH_TOKEN_KEY, value: result.refreshToken);
      }

      Map<String, dynamic>? userProfile;
      if (result is AuthorizationTokenResponse) {
        // ignore: unnecessary_cast
        userProfile = parseJwt((result as AuthorizationTokenResponse).idToken!);
        // print('ACCESS TOKEN ID: ${tokenResponse.idToken}');
      }

      // Send request to backend with providerID and return a user/new user
      var user = await getUser(providerID: userProfile!['sub']);
      if (user != null) {
        loggedInUser = user;
        return true;
      } else {
        // add the user
        user = await addUser(
            providerID: userProfile['sub'],
            email: userProfile['email'],
            name: userProfile['name'],
            picture: userProfile['picture']);
        // if everything goes fine, store the user's token on _secureStorage and return true
        await flutterSS.write(
          key: 'adusr_tk',
          value: user!.token,
        );
        // assign the user to the global loggedInUser
        loggedInUser = user;
        await flutterSS.write(
            key: 'adusr', value: jsonEncode(User.toMap(user)));
      }
      return true;
    } else {
      return false;
    }
  }

  /*
   */
  Future<User> fakeLogin() async {
    User user = User(
        providerID: '116459527113112845027',
        name: 'Saleh Abdurrahman',
        email: 'abdurrahmansalah619@gmail.com',
        picture:
            'https://lh3.googleusercontent.com/a/ALm5wu2-HbjVYvQP12-YOCBz9kQZCseK90tdjBTVcfRI=s96-c',
        token: 'g_FQwY0paIbZdgoXMhpb8A');

    loggedInUser = user;
    flutterSS.write(key: 'adusr', value: jsonEncode(User.toMap(user)));
    return user;
  }
}

class OAuthApp extends StatefulWidget {
  const OAuthApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OAuthAppState();
}

class _OAuthAppState extends State {
  bool isLoggedIn = false;
  bool isProgressing = false;

  setIsLoggedIn() {
    setState(() {
      isLoggedIn = true;
      isProgressing = false;
    });
  }

  setIsProgessing() {
    setState(() {
      isLoggedIn = false;
      isProgressing = true;
    });
  }

  setUnAuthenticated() {
    setState(() {
      isLoggedIn = false;
      isProgressing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final bool isLogout = await AuthService.instance.logout();
                  if (isLogout) {
                    setUnAuthenticated();
                  }
                },
                child: Icon(
                    isLoggedIn ? Icons.login_rounded : Icons.logout_rounded,
                    color: Colors.amber)),
            body: Builder(builder: (context) {
              if (isProgressing) {
                return const LoadingScreen();
              }

              if (isLoggedIn) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[50],
                  child: Center(
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                        ),
                        Text("Welcome you've successfully login.",
                            style: TextStyle(color: Colors.amberAccent))
                      ],
                    ),
                  ),
                );
              }

              return AuthenticationScreen(
                setIsLoggedState: setIsLoggedIn,
                setIsProgressingState: setIsProgessing,
                setUnAuthenticatedState: setUnAuthenticated,
              );
            })));
  }
}

class AuthenticationScreen extends StatelessWidget {
  final VoidCallback setIsLoggedState;
  final VoidCallback setIsProgressingState;
  final VoidCallback setUnAuthenticatedState;
  const AuthenticationScreen(
      {super.key,
      required this.setIsLoggedState,
      required this.setIsProgressingState,
      required this.setUnAuthenticatedState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
          onPressed: () async {
            setIsProgressingState();
            final authSuccess = await AuthService.instance.login();
            if (authSuccess) {
              setIsLoggedState();
            } else {
              setUnAuthenticatedState();
            }
          },
          icon: const Icon(Icons.login_rounded),
          label: const Text('Login')),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}
