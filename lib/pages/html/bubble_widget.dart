import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/pages/html/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';

/// Allows to display a bubble (formula, tip, proof, ...).
class BubbleWidget extends StatelessWidget {
  /// The bubble.
  final Bubble bubble;

  /// The bubble title.
  final String title;

  /// The bubble children.
  final List<Widget> children;

  /// Whether to put its content in a scrollable view.
  final bool inScrollableView;

  /// Creates a new bubble widget instance.
  const BubbleWidget({
    @required this.bubble,
    @required this.title,
    @required this.children,
    @required this.inScrollableView,
  });

  /// Creates a new bubble widget from a dom element.
  BubbleWidget.fromElement({
    @required dom.Element element,
    @required List<Widget> children,
  }) : this(
          bubble: BubbleUtils.of(element),
          title: element.attributes['data-api-v2-title'],
          children: children,
          inScrollableView: element.getElementsByTagName('table').isNotEmpty,
        );

  @override
  Widget build(BuildContext context) {
    BubbleTheme theme = context.watch<SettingsModel>().appTheme.themeData.bubbleThemes[bubble];
    Widget column = _createColumn(theme);
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: Border(
          left: BorderSide(
            color: theme.leftBorderColor,
            width: 8,
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: inScrollableView
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: column,
            )
          : column,
    );
  }

  /// Creates the content column.
  Widget _createColumn(theme) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TitleWidget.h4(
                  html: title,
                  textStyle: TextStyle(color: theme.leftBorderColor),
                ),
              ),
            ...children,
          ],
        ),
      );
}
