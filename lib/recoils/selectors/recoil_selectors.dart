import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:adventure_stories/commons/themes.dart';
import 'package:adventure_stories/models/user_model.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';

final userSelector = Selector<User?>(
    key: 'user_selector', getValue: (state) => state(userAtom) as User?);
/* represent the selected item in the menus */
final themeSelector = Selector<AppTheme?>(
    key: 'theme_selector', getValue: (state) => state(themeAtom) as AppTheme);
// determine wheather the app is in dark mode
final isDarkModeSelector = Selector<bool>(
    key: 'is_dark_mode_seletor', getValue: (state) => state(isDarkModeAtom) as bool);
/* represent the selected item in the menus */
final selectedMenuItemSelector = Selector<String?>(
    key: 'selectedMenuItem_selector',
    getValue: (state) => state(selectedMenuItemAtom) as String?);
