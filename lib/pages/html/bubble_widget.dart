import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/title_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

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
    BubbleTheme theme = context.resolveTheme().bubbleThemes[bubble];
    Widget column = _createColumn(theme);
    Widget bubbleWidget = Container(
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

    if (!bubble.isExpandable) {
      return bubbleWidget;
    }

    return _Expandable(
      expandText: 'Démonstration',
      content: bubbleWidget,
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

class _Expandable extends StatefulWidget {
  final String expandText;
  final Widget content;

  const _Expandable({
    @required this.expandText,
    @required this.content,
  });

  @override
  State<StatefulWidget> createState() => _ExpandableState();
}

class _ExpandableState extends State<_Expandable> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    Widget expandButton = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() => expanded = !expanded);
        },
        child: Text(
          (expanded ? '▼ ' : '▶ ') + widget.expandText,
          textAlign: TextAlign.right,
          style: const TextStyle(color: Colors.black54),
        ),
      ),
    );

    return expanded
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              expandButton,
              widget.content,
            ],
          )
        : expandButton;
  }
}
