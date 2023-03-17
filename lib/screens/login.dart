import 'dart:convert';
import 'dart:typed_data';

import 'package:adventure_stories/commons/utils.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';
import 'package:adventure_stories/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/widgets/layouts/tool_bar.dart';
import 'package:adventure_stories/models/user_model.dart';
import 'package:adventure_stories/widgets/theme_toggle_button.dart';
import 'package:adventure_stories/repositories/user_repository.dart';
import 'package:adventure_stories/commons/adventure_stories_icons.dart';

class Login extends RecoilWidget {
  const Login({super.key});

  textFunc(BuildContext context) async {
    // var userState = useRecoilState<User?>(userAtom);
    // bool? isDeleted = await deleteUser();
    // print('IS DELETED: $isDeleted');
    // var result = await AuthService.instance.fakeLogin();
    var result = await AuthService.instance.login();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushNamed('home_screen');
    // userState.setData(result);
    // print('RESULT: $result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flex(direction: Axis.vertical, children: [
            ToolBar(children: <Widget>[
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'home_screen');
                      },
                      icon: const Icon(AdventureStories.home)),
                  IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  const ThemeToggle()
                ],
              ),
            ]),
            Expanded(
                child: Center(
                    child: SizedBox(
                        width: 160,
                        height: 50,
                        child: OutlinedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20))),
                            onPressed: () => textFunc(context),
                            child: Row(children: [
                              Icon(Icons.login,
                                  color: Theme.of(context).iconTheme.color),
                              Text(
                                'Google sign in',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            ])))))
          ])),
    ));
  }
}
