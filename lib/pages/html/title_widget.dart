import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a title.
class TitleWidget extends StatelessWidget {
  /// The base size.
  static const int _BASE_SIZE = 16;

  /// The text style.
  final TextStyle textStyle;

  /// The decoration.
  final BoxDecoration decoration;

  /// The html content.
  final String html;

  /// The container padding.
  final EdgeInsets padding;

  /// The container margin.
  final EdgeInsets margin;

  /// Creates a new headline 2 formatted title.
  TitleWidget.h2({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 2.4 * _BASE_SIZE,
          fontFamily: 'FuturaBT',
          color: const Color(0xff23618a),
        ),
        decoration = const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        ),
        padding = const EdgeInsets.only(bottom: 0.5 * _BASE_SIZE),
        margin = const EdgeInsets.only(bottom: 1.4 * _BASE_SIZE);

  /// Creates a new headline 3 formatted title.
  TitleWidget.h3({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 1.75 * _BASE_SIZE,
          fontFamily: 'FuturaBT',
          color: const Color(0xff3498db),
        ),
        decoration = null,
        padding = null,
        margin = const EdgeInsets.only(bottom: 1.0 * _BASE_SIZE);

  /// Creates a new headline 4 formatted title.
  TitleWidget.h4({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 1.25 * _BASE_SIZE,
          fontFamily: 'FuturaBT',
        ),
        decoration = null,
        padding = null,
        margin = const EdgeInsets.only(bottom: 0.75 * _BASE_SIZE);

  /// Creates a new title widget from the specified element.
  factory TitleWidget.fromElement({
    @required TextStyle textStyle,
    @required dom.Element element,
  }) {
    switch (element.localName) {
      case 'h3':
        return TitleWidget.h3(
          textStyle: textStyle,
          html: element.innerHtml,
        );
      case 'h4':
        return TitleWidget.h4(
          textStyle: textStyle,
          html: element.innerHtml,
        );
      default:
        return TitleWidget.h2(
          textStyle: textStyle,
          html: element.innerHtml,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = RegExp(r'<\/?[a-z][\s\S]*>', caseSensitive: false).hasMatch(html)
        ? AppHtmlWidget(
            data: html,
            buildAsync: false,
            textStyle: textStyle,
          )
        : Text(
            html,
            style: textStyle,
          );

    return Container(
      decoration: decoration,
      width: decoration == null ? null : MediaQuery.of(context).size.width,
      margin: margin,
      child: child,
    );
  }
}
