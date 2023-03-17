// cornerstone Abstract class for the Application Theme.
// this provider a dependency injection
import 'package:flutter/material.dart';

abstract class AppTheme {
  // abstract property for any theme
  ThemeData get themeData;
}

Map<String, Color> lightThemeColors = {
  'text': const Color(0xFF434343),
  'hoverColor': const Color(0xFFA1A1A1),
  'cardColor': const Color(0xFFE1E1E1),
  'highlightColor': const Color.fromARGB(214, 255, 0, 136),
  'backgroundColor': const Color(0xFFFFFFFF),
  'secondaryHeaderColor': const Color(0xFF636363),
  'bottomNavigationBarThemeBackgroundColor': const Color(0xFFEEEEEE),
  'blackOpacity0_1': Colors.black.withOpacity(0.1)
};
Map<String, Color> darkThemeColors = {
  'text': const Color(0xFFE1E1E1),
  'hoverColor': const Color(0xFFA1A1A1),
  'cardColor': const Color(0xFF0F3460),
  'highlightColor': const Color.fromARGB(214, 255, 0, 136),
  'backgroundColor': const Color(0xFF16213E),
  'secondaryHeaderColor': const Color(0xFF636363),
  'blackOpacity0_1': Colors.black.withOpacity(0.3)
};

TextStyle _textStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w600,
  color: lightThemeColors['text'],
  overflow: TextOverflow.ellipsis,
);

//represent a LightThemeMode
class LightThemeMode extends AppTheme {
  @override
  ThemeData themeData = ThemeData(
      brightness: Brightness.light,
      /*  This property holds a single color that becomes the background color 
        for major parts of the app (toolbars, tab bars, etc). 
        This comes with two variants primaryColorLight and primaryColorDark. */
      primaryColor: lightThemeColors['backgroundColor'],
      /*
     */
      scaffoldBackgroundColor: lightThemeColors['backgroundColor'],
      /*
     */
      textTheme: TextTheme(
        caption: _textStyle,
        button: _textStyle,
      ),
      /*
        This property define the colorSchemes that include:
        - secondary => for text colors 
        - primary =>
        - brighness => overall brightness for the color scheme
    */
      colorScheme: ColorScheme.light(
          secondary: lightThemeColors['hoverColor']!,
          primary: lightThemeColors['text']!,
          brightness: Brightness.light),
      /*
      could be use as a general backgroundColor
     */
      backgroundColor: lightThemeColors['backgroundColor'],
      /*
       Icons themes
     */
      iconTheme: const IconThemeData(
          color: Color(0xFF999999),
          size: 16,
          shadows: [Shadow(color: Colors.black12, offset: Offset.zero)]),
      /* */
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          backgroundColor:
              lightThemeColors['bottomNavigationBarThemeBackgroundColor'],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting),
      /* for menu and menu item */
      secondaryHeaderColor: lightThemeColors['secondaryHeaderColor'],
      /* */
      highlightColor: lightThemeColors['highlightColor'],
      // Card Color
      cardColor: lightThemeColors['cardColor'],
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.grey, refreshBackgroundColor: Colors.grey),
      // implement for skeleton colors
      hintColor: Colors.grey.shade100,
      dividerColor: darkThemeColors['blackOpacity0_1']);
}

// represent a DarkThemeMode
class DarkThemeMode extends AppTheme {
  @override
  ThemeData themeData = ThemeData(
      brightness: Brightness.dark,
      /*  This property holds a single color that becomes the background color 
        for major parts of the app (toolbars, tab bars, etc). 
        This comes with two variants primaryColorLight and primaryColorDark. */
      primaryColor: darkThemeColors['backgroundColor'],
      /*
     */
      scaffoldBackgroundColor: darkThemeColors['backgroundColor'],
      /*
     */
      textTheme: TextTheme(
        caption: _textStyle,
        button: _textStyle,
      ),
      /*
        This property define the colorSchemes that include:
        - secondary => for text colors 
        - primary =>
        - brighness => overall brightness for the color scheme
    */
      colorScheme: ColorScheme.dark(
          secondary: darkThemeColors['hoverColor']!,
          primary: darkThemeColors['text']!,
          brightness: Brightness.dark),
      /*
      could be use as a general backgroundColor
     */
      backgroundColor: darkThemeColors['backgroundColor'],
      /*
       Icons themes
     */
      iconTheme: const IconThemeData(
          size: 16,
          color: Color(0xFF999999),
          shadows: [Shadow(color: Colors.black12, offset: Offset.zero)]),
      /* */
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          backgroundColor: darkThemeColors['backgroundColor'],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting),
      /* for menu and menu item */
      secondaryHeaderColor: darkThemeColors['secondaryHeaderColor'],
      /* */
      highlightColor: darkThemeColors['highlightColor'],
      // Card Color
      cardColor: darkThemeColors['blackOpacity0_1'],
      progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color(0xFFE94560), refreshBackgroundColor: Color(0xFFE94560)),
      // implement for skeleton colors
      hintColor: darkThemeColors['blackOpacity0_1'],
      dividerColor: darkThemeColors['blackOpacity0_1']);
}
