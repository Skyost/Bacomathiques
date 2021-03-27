import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/utils/expandable_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a bubble (formula, tip, proof, ...).
class BubbleWidget extends StatefulWidget {
  /// The bubble.
  final Bubble bubble;

  /// The bubble children.
  final List<Widget> children;

  /// Whether to put its content in a scrollable view.
  final bool inScrollableView;

  /// Creates a new bubble widget instance.
  const BubbleWidget({
    required this.bubble,
    required this.children,
    required this.inScrollableView,
  });

  /// Creates a new bubble widget from a dom element.
  BubbleWidget.fromElement({
    required dom.Element element,
    required List<Widget> children,
  }) : this(
          bubble: BubbleUtils.of(element),
          children: children,
          inScrollableView: BubbleWidget._inScrollableView(element),
        );

  @override
  State<StatefulWidget> createState() => _BubbleWidgetState();

  /// Whether the widget should in a scrollable view.
  static bool _inScrollableView(dom.Element element) {
    if (element.getElementsByTagName('table').isNotEmpty || element.getElementsByTagName('pre').isNotEmpty) {
      return true;
    }

    return element.attributes['data-content-width'] == 'big';
  }
}

/// The bubble widget state.
class _BubbleWidgetState extends State<BubbleWidget> {
  /// Whether to show the label.
  bool showLabel = false;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.resolveTheme();
    BubbleTheme bubbleTheme = theme.bubbleThemes[widget.bubble]!;
    Widget column = _createColumn(bubbleTheme);
    Widget bubbleWidget = GestureDetector(
      onTap: () {
        setState(() => showLabel = !showLabel);
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: bubbleTheme.backgroundColor,
              border: Border(
                left: BorderSide(
                  color: bubbleTheme.leftBorderColor,
                  width: 8,
                ),
              ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: widget.inScrollableView
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: column,
                  )
                : column,
          ),
          AnimatedOpacity(
            opacity: showLabel ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: bubbleTheme.leftBorderColor,
              padding: const EdgeInsets.only(left: 10, top: 2, right: 6, bottom: 2),
              child: Text(
                widget.bubble.bubbleLabel.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );

    if (!widget.bubble.isExpandable) {
      return bubbleWidget;
    }

    return Expandable(
      expandText: widget.bubble.expandButton!,
      expandTextStyle: TextStyle(color: theme.accentColor),
      content: bubbleWidget,
    );
  }

  /// Creates the content column.
  Widget _createColumn(BubbleTheme theme) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        ),
      );
}
