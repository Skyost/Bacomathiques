import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
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
    @required Bubble bubble,
    @required dom.Element element,
    @required List<Widget> children,
  }) : this(
          bubble: bubble,
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

  Widget _createTitle({
    @required String title,
    @required TextStyle textStyle,
  }) {
    if (title.contains('<math>')) {
      return AppHtmlWidget(
        data: title,
        buildAsync: false,
        textStyle: textStyle,
      );
    }
    return Text(
      title,
      style: textStyle,
    );
  }

  /// Creates the content column.
  Widget _createColumn(theme) => Provider<BubbleTheme>.value(
        value: theme,
        child: title == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _createTitle(
                  title: title,
                  textStyle: TextStyle(
                    color: theme.leftBorderColor,
                    fontSize: 20,
                    fontFamily: 'FuturaBT',
                  ),
                ),
              ),
        builder: (context, child) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (child != null) child,
              ...children,
            ],
          ),
        ),
      );
}
