import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;

/// Allows to get the color according to the specified app theme.
typedef ColorGetter = Color? Function(AppTheme theme, dom.Element element);

/// Allows to display a title.
class TitleWidget extends ConsumerWidget {
  /// The base size.
  static const int _BASE_SIZE = 16;

  /// The font size.
  final double fontSize;

  /// Returns the color of this title according to the provided theme.
  final ColorGetter? getColor;

  /// Returns the border bottom color of this title according to the provided theme.
  final ColorGetter? getBorderBottomColor;

  /// The DOM element.
  final dom.Element element;

  /// The container padding.
  final EdgeInsets? padding;

  /// The container margin.
  final EdgeInsets? margin;

  /// Creates a new headline 2 formatted title.
  const TitleWidget.h2({
    required this.element,
  })  : fontSize = 2.4 * _BASE_SIZE,
        getColor = _getH2Color,
        getBorderBottomColor = _getH2BorderBottomColor,
        padding = const EdgeInsets.only(bottom: 0.5 * _BASE_SIZE),
        margin = const EdgeInsets.only(bottom: 0.3 * _BASE_SIZE);

  /// Creates a new headline 3 formatted title.
  const TitleWidget.h3({
    required this.element,
  })  : fontSize = 1.75 * _BASE_SIZE,
        getColor = _getH3Color,
        getBorderBottomColor = null,
        padding = const EdgeInsets.only(bottom: 0.8 * _BASE_SIZE),
        margin = null;

  /// Creates a new headline 4 formatted title.
  const TitleWidget.h4({
    required this.element,
  })  : fontSize = 1.25 * _BASE_SIZE,
        getColor = _getH4Color,
        getBorderBottomColor = null,
        padding = const EdgeInsets.only(bottom: 0.75 * _BASE_SIZE),
        margin = null;

  /// Creates a new title widget from the specified element.
  factory TitleWidget.fromElement({
    required dom.Element element,
  }) {
    switch (element.localName) {
      case 'h3':
        return TitleWidget.h3(element: element);
      case 'h4':
        return TitleWidget.h4(element: element);
      default:
        return TitleWidget.h2(element: element);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    TextStyle textStyle = TextStyle(
        fontFamily: 'FuturaBT',
        fontSize: fontSize,
        color: (getColor == null ? theme.textColor : getColor!(theme, element)) ?? theme.textColor,
      );

    Widget child = RegExp(r'<\/?[a-z][\s\S]*>', caseSensitive: false).hasMatch(element.innerHtml)
        ? AppHtmlWidget(
            data: element.innerHtml,
            buildAsync: false,
            textStyle: textStyle,
          )
        : Text(
            element.innerHtml,
            style: textStyle,
          );

    Color? borderBottomColor = getBorderBottomColor == null ? null : getBorderBottomColor!(theme, element);
    return Container(
      decoration: borderBottomColor == null
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderBottomColor,
                ),
              ),
            ),
      width: MediaQuery.of(context).size.width,
      margin: margin,
      padding: padding,
      child: child,
    );
  }

  /// Returns the color of the headline 2 according to the specified theme.
  static Color? _getH2Color(AppTheme theme, dom.Element element) => theme.h2Color;

  /// Returns the border bottom color of the headline 2 according to the specified theme.
  static Color? _getH2BorderBottomColor(AppTheme theme, dom.Element element) => theme.hrColor;

  /// Returns the color of the headline 3 according to the specified theme.
  static Color? _getH3Color(AppTheme theme, dom.Element element) => theme.h3Color;

  /// Returns the color of the headline 4 according to the specified theme.
  static Color? _getH4Color(AppTheme theme, dom.Element element) {
    Bubble bubble = BubbleUtils.getByClassName(element.attributes['data-parent-bubble']);
    return theme.bubbleThemes[bubble]?.leftBorderColor;
  }
}
