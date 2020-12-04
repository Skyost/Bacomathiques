import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a title.
class TitleWidget extends StatelessWidget {
  /// The text style.
  final TextStyle textStyle;
  /// The decoration.
  final BoxDecoration decoration;
  /// The html content.
  final String html;

  /// Creates a new headline 2 formatted title.
  TitleWidget.h2({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 2.4 * 16,
          fontFamily: 'FuturaBT',
          color: const Color(0xff23618a),
        ),
        decoration = const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12)),
        );

  /// Creates a new headline 3 formatted title.
  TitleWidget.h3({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 1.75 * 16,
          fontFamily: 'FuturaBT',
          color: const Color(0xff3498db),
        ),
        decoration = null;

  /// Creates a new headline 4 formatted title.
  TitleWidget.h4({
    @required TextStyle textStyle,
    @required this.html,
  })  : textStyle = textStyle.copyWith(
          fontSize: 1.25 * 16,
          fontFamily: 'FuturaBT',
        ),
        decoration = null;

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

    return decoration == null
        ? child
        : Container(
            decoration: decoration,
            child: child,
          );
  }
}
