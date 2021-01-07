import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a bubble (formula, tip, proof, ...).
class BubbleWidget extends StatelessWidget {
  /// The bubble.
  final Bubble bubble;

  /// The bubble children.
  final List<Widget> children;

  /// Whether to put its content in a scrollable view.
  final bool inScrollableView;

  /// Creates a new bubble widget instance.
  const BubbleWidget({
    @required this.bubble,
    @required this.children,
    @required this.inScrollableView,
  });

  /// Creates a new bubble widget from a dom element.
  BubbleWidget.fromElement({
    @required dom.Element element,
    @required List<Widget> children,
  }) : this(
          bubble: BubbleUtils.of(element),
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
      expandText: bubble.expandButton,
      content: bubbleWidget,
    );
  }

  /// Creates the content column.
  Widget _createColumn(BubbleTheme theme) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
}

/// Allows to show an expandable widget.
class _Expandable extends StatefulWidget {
  /// The expand text.
  final String expandText;

  /// The expanded content.
  final Widget content;

  /// Creates a new expandable widget instance.
  const _Expandable({
    @required this.expandText,
    @required this.content,
  });

  @override
  State<StatefulWidget> createState() => _ExpandableState();
}

/// The expandable state.
class _ExpandableState extends State<_Expandable> {
  /// Whether this widget is expanded.
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
          style: TextStyle(color: context.resolveTheme().accentColor),
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
