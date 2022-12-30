import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Contains the application theme data.
abstract class AppTheme {
  /// The light theme instance.
  static const AppTheme light = _LightAppTheme();

  /// The dark theme instance.
  static const AppTheme dark = _DarkAppTheme();

  /// The app theme brightness.
  final Brightness brightness;

  /// The primary color.
  final Color primaryColor;

  /// The primary color but darkened.
  final Color primaryColorDark;

  /// The accent color.
  final Color accentColor;

  /// The action bar color.
  final Color actionBarColor;

  /// The lesson button color.
  final Color blueButtonColor;

  /// The speciality button color.
  final Color greenButtonColor;

  /// The comments border radius.
  final double commentBorderRadius;

  /// The comments background color.
  final Color commentBackgroundColor;

  /// The comments date color.
  final Color commentDateColor;

  /// The scaffold background color.
  final Color? scaffoldBackgroundColor;

  /// The lesson chapter color.
  final Color? lessonChapterColor;

  /// The lesson background color.
  final Color? lessonBackgroundColor;

  /// The text color.
  final Color? textColor;

  /// The progress indicator color.
  final Color progressIndicatorColor;

  /// The highlight color.
  final Color highlightColor;

  /// The headline 2 color.
  final Color? h2Color;

  /// The headline 2 size.
  final double h2Size;

  /// The headline 3 color.
  final Color? h3Color;

  /// The headline 3 size.
  final double h3Size;

  /// The headline 4 size.
  final double h4Size;

  /// The horizontal rule color.
  final Color? hrColor;

  /// The input decoration color.
  final Color inputDecorationColor;

  /// Contains all bubble themes.
  final Map<Bubble, BubbleTheme> bubbleThemes;

  /// Creates a new app theme data instance.
  const AppTheme({
    required this.brightness,
    required this.primaryColor,
    required this.primaryColorDark,
    required this.accentColor,
    required this.actionBarColor,
    this.blueButtonColor = const Color(0xFF217DBB),
    this.greenButtonColor = const Color(0xFF3CA797),
    this.commentBorderRadius = 15,
    required this.commentBackgroundColor,
    required this.commentDateColor,
    this.scaffoldBackgroundColor,
    this.lessonChapterColor,
    this.lessonBackgroundColor,
    this.textColor,
    required this.progressIndicatorColor,
    this.highlightColor = Colors.black12,
    this.h2Color,
    this.h2Size = 38,
    this.h3Size = 28,
    this.h4Size = 20,
    this.h3Color,
    this.hrColor,
    required this.inputDecorationColor,
    required this.bubbleThemes,
  });

  /// Returns the flutter theme data.
  ThemeData get flutterThemeData => ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        appBarTheme: AppBarTheme(
          color: actionBarColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(color: textColor),
          headline2: TextStyle(color: textColor),
          headline3: TextStyle(color: textColor),
          headline4: TextStyle(color: textColor),
          headline5: TextStyle(color: textColor),
          headline6: TextStyle(color: textColor),
          subtitle1: TextStyle(color: textColor),
          subtitle2: TextStyle(color: textColor),
          bodyText1: TextStyle(color: textColor),
          bodyText2: TextStyle(color: textColor),
          caption: TextStyle(color: textColor),
          button: TextStyle(color: accentColor),
          overline: TextStyle(color: textColor),
        ),
        unselectedWidgetColor: accentColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        dialogBackgroundColor: scaffoldBackgroundColor,
        highlightColor: highlightColor,
        splashColor: highlightColor,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          highlightColor: highlightColor,
          splashColor: highlightColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: accentColor),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputDecorationColor),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: inputDecorationColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: inputDecorationColor),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
      );
}

/// The light app theme data.
class _LightAppTheme extends AppTheme {
  /// Creates a new light app theme data instance.
  const _LightAppTheme()
      : super(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF3498DB),
          primaryColorDark: const Color(0xFF3498DB),
          accentColor: const Color(0xFF757575),
          actionBarColor: const Color(0xFF2489CC),
          commentBackgroundColor: const Color(0xFFE1F0FA),
          commentDateColor: const Color(0xFF6C757D),
          lessonChapterColor: const Color(0xff6c757d),
          progressIndicatorColor: const Color(0xFF29CBB1),
          h2Color: const Color(0xff23618a),
          h3Color: const Color(0xff3498db),
          hrColor: const Color(0xffcecece),
          inputDecorationColor: const Color(0xFF3498DB),
          bubbleThemes: const {
            Bubble.formula: BubbleTheme(
              backgroundColor: Color(0xffebf3fb),
              leftBorderColor: Color(0xff3498db),
              linkColor: Color(0xff217dbb),
              linkDecorationColor: Color(0xffa0cfee),
            ),
            Bubble.proof: BubbleTheme(
              backgroundColor: Color(0xfffff8de),
              leftBorderColor: Color(0xfff1c40f),
              linkColor: Color(0xffe09e0d),
              linkDecorationColor: Color(0xfff1c40f),
            ),
            Bubble.tip: BubbleTheme(
              backgroundColor: Color(0xffdcf3d8),
              leftBorderColor: Color(0xff208d4d),
              linkColor: Color(0xff13532e),
              linkDecorationColor: Color(0xff219150),
            ),
            Bubble.exercise: BubbleTheme(
              backgroundColor: Color(0xffe0f2f1),
              leftBorderColor: Color(0xff009688),
              linkColor: Color(0xff006f65),
              linkDecorationColor: Color(0xff009688),
            ),
            Bubble.correction: BubbleTheme(
              backgroundColor: Color(0xffe0f7fa),
              leftBorderColor: Color(0xff00bcd4),
              linkColor: Color(0xff006b78),
              linkDecorationColor: Color(0xff00bcd4),
            ),
          },
        );
}

/// The dark app theme data.
class _DarkAppTheme extends AppTheme {
  /// Creates a new dark app theme data instance.
  const _DarkAppTheme()
      : super(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF253341),
          primaryColorDark: const Color(0xFF192734),
          accentColor: const Color(0xFF91A4B3),
          actionBarColor: const Color(0xFF253341),
          commentBackgroundColor: const Color(0xFF192734),
          commentDateColor: const Color(0xff6c757d),
          scaffoldBackgroundColor: const Color(0xFF15202B),
          lessonChapterColor: const Color(0xff6c757d),
          lessonBackgroundColor: const Color(0xFF192734),
          textColor: Colors.white,
          progressIndicatorColor: Colors.white,
          hrColor: const Color(0xff2e2e2e),
          inputDecorationColor: Colors.white,
          bubbleThemes: const {
            Bubble.formula: BubbleTheme(
              backgroundColor: Color(0xff192734),
              leftBorderColor: Color(0xff3498db),
              linkColor: Colors.white,
              linkDecorationColor: Colors.white,
            ),
            Bubble.proof: BubbleTheme(
              backgroundColor: Color(0xff192734),
              leftBorderColor: Color(0xfff1c40f),
              linkColor: Colors.white,
              linkDecorationColor: Colors.white,
            ),
            Bubble.tip: BubbleTheme(
              backgroundColor: Color(0xff192734),
              leftBorderColor: Color(0xff208d4d),
              linkColor: Colors.white,
              linkDecorationColor: Colors.white,
            ),
            Bubble.exercise: BubbleTheme(
              backgroundColor: Color(0xff192734),
              leftBorderColor: Color(0xff009688),
              linkColor: Colors.white,
              linkDecorationColor: Colors.white,
            ),
            Bubble.correction: BubbleTheme(
              backgroundColor: Color(0xff192734),
              leftBorderColor: Color(0xff00bcd4),
              linkColor: Colors.white,
              linkDecorationColor: Colors.white,
            ),
          },
        );
}
