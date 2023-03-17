import 'dart:convert';

import 'package:adventure_stories/commons/themes.dart';
import 'package:adventure_stories/models/user_model.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';
import 'package:adventure_stories/screens/story/main_story.dart';
import 'package:adventure_stories/screens/user/main_user.dart';
import 'package:adventure_stories/services/user_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'screens/login.dart';
import 'screens/main_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/commons/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adventure_stories/recoils/selectors/recoil_selectors.dart';

void main() async {
  /* 
    this is needed by the FlutterConfig
   */
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();
  // Instantiate the global FlutterSecureStorage instance
  flutterSS = const FlutterSecureStorage();
  // flutter
  await AuthService.instance.initAuth();
  /** Initialize the GraphqlClient instance */
  gqlClient = ValueNotifier(GraphQLClient(
      link: AuthLink(getToken: () async => 'Bearer ${await flutterSS.read(key: 'adusr_tk')}').concat(HttpLink('http://127.0.0.1:3000/graphql')),
      cache: GraphQLCache(store: InMemoryStore())));
  //
  // flutterSS.deleteAll();
  String? aduser = await flutterSS.read(key: 'adusr');
  if (aduser != null) {
    final data = jsonDecode(aduser);
    loggedInUser = User(
        providerID: data['providerID'],
        name: data['name'],
        email: data['email'],
        picture: data['picture'],
        token: data['token']);
    // print(loggedInUser.toString());
  }
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RecoilProvider(
        child: GraphQLProvider(client: gqlClient, child: const App()));
  } // end build
} // end Main

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // initial the user
    // var userState = useRecoilState(userAtom);
    // userState.setData(loggedInUser);
    /*Use Recoil themes*/
    ThemeData appTheme = useRecoilSelectorState(themeSelector)!.themeData;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adventure Stories',
        theme: appTheme,
        home: const MainHome(),
        routes: {
          'home_screen': (context) => const MainHome(),
          'account_screen': (context) => const Account(),
          'stories_screen': (context) => const MyStories(),
          'login_screen': (context) => const Login()
        });
  }
}
