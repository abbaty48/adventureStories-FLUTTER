import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/commons/themes.dart';
import 'package:adventure_stories/models/user_model.dart';

final userAtom = Atom<User?>(key: 'user_atom', defaultValue: null);
final themeAtom =
    Atom<AppTheme>(key: 'theme_mode', defaultValue: LightThemeMode());
final isDarkModeAtom = Atom<bool>(key: 'is_dark_mode', defaultValue: false);
final selectedMenuItemAtom =
    Atom<String?>(key: 'selectedMenuItem_atom', defaultValue: null);
