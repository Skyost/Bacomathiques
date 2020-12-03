import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Contains some information about the app.
class App {
  /// The application name.
  static const String APP_NAME = 'Bacomathiques';

  /// The day night switch / icon breakpoint (width).
  static const double DAY_NIGHT_SWITCH_WIDTH_BREAKPOINT = 410;
}

/// The application theme.
class AppTheme {
  /// The application theme data.
  AppThemeData themeData;

  /// Creates a new app theme instance.
  AppTheme() {
    load(true);
  }

  /// Loads the theme data according to the provided boolean.
  void load(bool light) {
    bool hasChanged = themeData == null || (!light && themeData is LightAppThemeData) || (light && themeData is DarkAppThemeData);

    if (hasChanged) {
      themeData = light ? const LightAppThemeData() : const DarkAppThemeData();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: themeData.actionBarColor));
    }
  }

  /// Returns the flutter theme data.
  ThemeData get flutterThemeData => ThemeData(
        primaryColor: themeData.primaryColor,
        primaryColorDark: themeData.primaryColorDark,
        accentColor: themeData.accentColor,
        appBarTheme: AppBarTheme(color: themeData.actionBarColor),
        textTheme: TextTheme(
          headline1: TextStyle(color: themeData.textColor),
          headline2: TextStyle(color: themeData.textColor),
          headline3: TextStyle(color: themeData.textColor),
          headline4: TextStyle(color: themeData.textColor),
          headline5: TextStyle(color: themeData.textColor),
          headline6: TextStyle(color: themeData.textColor),
          subtitle1: TextStyle(color: themeData.textColor),
          subtitle2: TextStyle(color: themeData.textColor),
          bodyText1: TextStyle(color: themeData.textColor),
          bodyText2: TextStyle(color: themeData.textColor),
          caption: TextStyle(color: themeData.textColor),
          button: TextStyle(color: themeData.accentColor),
          overline: TextStyle(color: themeData.textColor),
        ),
        scaffoldBackgroundColor: themeData.scaffoldBackgroundColor,
        dialogBackgroundColor: themeData.scaffoldBackgroundColor,
        highlightColor: themeData.highlightColor,
        splashColor: themeData.highlightColor,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          highlightColor: themeData.highlightColor,
          splashColor: themeData.highlightColor,
        ),
      );
}

/// Contains the application theme data.
abstract class AppThemeData {
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
  final Color scaffoldBackgroundColor;

  /// The lesson background color.
  final Color lessonBackgroundColor;

  /// The text color.
  final Color textColor;

  /// The progress indicator color.
  final Color progressIndicatorColor;

  /// The highlight color.
  final Color highlightColor;

  final Map<Bubble, BubbleTheme> bubbleThemes;

  /// Creates a new app theme data instance.
  const AppThemeData({
    @required this.primaryColor,
    @required this.primaryColorDark,
    @required this.accentColor,
    @required this.actionBarColor,
    this.blueButtonColor = const Color(0xFF217DBB),
    this.greenButtonColor = const Color(0xFF3CA797),
    this.commentBorderRadius = 15,
    @required this.commentBackgroundColor,
    @required this.commentDateColor,
    this.scaffoldBackgroundColor,
    this.lessonBackgroundColor,
    this.textColor,
    @required this.progressIndicatorColor,
    this.highlightColor = Colors.black12,
    @required this.bubbleThemes,
  });
}

/// The light app theme data.
class LightAppThemeData extends AppThemeData {
  /// Creates a new light app theme data instance.
  const LightAppThemeData()
      : super(
          primaryColor: const Color(0xFF3498DB),
          primaryColorDark: const Color(0xFF3498DB),
          accentColor: const Color(0xFF757575),
          actionBarColor: const Color(0xFF2489CC),
          commentBackgroundColor: const Color(0xFFE1F0FA),
          commentDateColor: const Color(0xFF6C757D),
          progressIndicatorColor: const Color(0xFF29CBB1),
          bubbleThemes: const {
            Bubble.FORMULA: BubbleTheme(
              backgroundColor: Color(0xffebf3fb),
              leftBorderColor: Color(0xff3498db),
              linkColor: Color(0xff217dbb),
              linkDecorationColor: Color(0xffa0cfee),
            ),
            Bubble.TIP: BubbleTheme(
              backgroundColor: Color(0xffdcf3d8),
              leftBorderColor: Color(0xff208d4d),
              linkColor: Color(0xff13532e),
              linkDecorationColor: Color(0xff219150),
            ),
            Bubble.PROOF: BubbleTheme(
              backgroundColor: Color(0xfffff8de),
              leftBorderColor: Color(0xfff1c40f),
            ),
          },
        );
}

/// The dark app theme data.
class DarkAppThemeData extends AppThemeData {
  /// Creates a new dark app theme data instance.
  const DarkAppThemeData()
      : super(
          primaryColor: const Color(0xFF253341),
          primaryColorDark: const Color(0xFF192734),
          accentColor: const Color(0xFF91A4B3),
          actionBarColor: const Color(0xFF253341),
          commentBackgroundColor: const Color(0xFF192734),
          commentDateColor: const Color(0xFF6C757D),
          scaffoldBackgroundColor: const Color(0xFF15202B),
          lessonBackgroundColor: const Color(0xFF192734),
          textColor: Colors.white,
          progressIndicatorColor: Colors.white,
          bubbleThemes: const {
            Bubble.FORMULA: BubbleTheme(
              leftBorderColor: Color(0xff3498db),
              linkColor: Color(0xff217dbb),
              linkDecorationColor: Color(0xffa0cfee),
            ),
            Bubble.TIP: BubbleTheme(
              leftBorderColor: Color(0xff208d4d),
              linkColor: Color(0xff13532e),
              linkDecorationColor: Color(0xff219150),
            ),
            Bubble.PROOF: BubbleTheme(leftBorderColor: Color(0xfff1c40f)),
          },
        );
}

/// Contains all possible bubbles.
enum Bubble {
  /// Formula bubble.
  FORMULA,

  /// Tip bubble.
  TIP,

  /// Proof bubble.
  PROOF
}

/// The bubble class extension.
extension BubbleClass on Bubble {
  /// Returns the bubble CSS class name.
  String get className {
    switch (this) {
      case Bubble.FORMULA:
        return 'formula';
      case Bubble.TIP:
        return 'tip';
      case Bubble.PROOF:
        return 'proof';
    }
    return null;
  }
}

/// A bubble theme.
class BubbleTheme {
  /// The background color.
  final Color backgroundColor;

  /// The left border color.
  final Color leftBorderColor;

  /// The link color.
  final Color linkColor;

  /// The link decoration color.
  final Color linkDecorationColor;

  /// Creates a new bubble theme instance.
  const BubbleTheme({
    this.backgroundColor,
    @required this.leftBorderColor,
    this.linkColor,
    this.linkDecorationColor,
  });
}
