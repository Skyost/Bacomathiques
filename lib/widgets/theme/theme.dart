import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// Contains the application theme data.
abstract class AppTheme {
  /// The light theme instance.
  static final AppTheme light = _LightAppTheme();

  /// The dark theme instance.
  static final AppTheme dark = _DarkAppTheme();

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

  /// The code background color.
  final Color? codeBackgroundColor;

  /// Contains all bubble themes.
  final Map<Bubble, BubbleTheme> bubbleThemes;

  /// The current highlighter theme.
  late final HighlighterTheme _highlighterTheme;

  /// Creates a new app theme data instance.
  AppTheme({
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
    this.codeBackgroundColor,
    required this.bubbleThemes,
  }) {
    HighlighterTheme.loadForBrightness(brightness).then((highlighterTheme) => _highlighterTheme = highlighterTheme);
  }

  /// Returns the flutter theme data.
  ThemeData get flutterThemeData => ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        appBarTheme: AppBarTheme(
          color: actionBarColor,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scrollbarTheme: const ScrollbarThemeData(
          radius: Radius.circular(0),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: textColor),
          displayMedium: TextStyle(color: textColor),
          displaySmall: TextStyle(color: textColor),
          headlineMedium: TextStyle(color: textColor),
          headlineSmall: TextStyle(color: textColor),
          titleLarge: TextStyle(color: textColor),
          titleMedium: TextStyle(color: textColor),
          titleSmall: TextStyle(color: textColor),
          bodyLarge: TextStyle(color: textColor),
          bodyMedium: TextStyle(color: textColor),
          bodySmall: TextStyle(color: textColor),
          labelLarge: TextStyle(color: accentColor),
          labelSmall: TextStyle(color: textColor),
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

  /// Creates the highlighter theme.
  HighlighterTheme get highlighterTheme => _highlighterTheme;
}

/// The light app theme data.
class _LightAppTheme extends AppTheme {
  /// Creates a new light app theme data instance.
  _LightAppTheme()
      : super(
          brightness: Brightness.light,
          primaryColor: const Color(0xff3498DB),
          primaryColorDark: const Color(0xff3498DB),
          scaffoldBackgroundColor: Colors.white,
          accentColor: const Color(0xff757575),
          actionBarColor: const Color(0xff2489cc),
          commentBackgroundColor: const Color(0xffe1f0fa),
          commentDateColor: const Color(0xff6c757d),
          lessonChapterColor: const Color(0xff6c757d),
          lessonBackgroundColor: Colors.white,
          progressIndicatorColor: const Color(0xff29cbb1),
          h2Color: const Color(0xff23618a),
          h3Color: const Color(0xff3498db),
          hrColor: const Color(0xffcecece),
          inputDecorationColor: const Color(0xff3498db),
          codeBackgroundColor: Colors.white,
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
  _DarkAppTheme()
      : super(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff253341),
          primaryColorDark: const Color(0xff192734),
          accentColor: const Color(0xff91A4B3),
          actionBarColor: const Color(0xff253341),
          commentBackgroundColor: const Color(0xff192734),
          commentDateColor: const Color(0xff6c757d),
          scaffoldBackgroundColor: const Color(0xff15202b),
          lessonChapterColor: const Color(0xff6c757d),
          lessonBackgroundColor: const Color(0xff192734),
          textColor: Colors.white,
          progressIndicatorColor: Colors.white,
          hrColor: const Color(0xff2e2e2e),
          inputDecorationColor: Colors.white,
          codeBackgroundColor: Colors.black,
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
