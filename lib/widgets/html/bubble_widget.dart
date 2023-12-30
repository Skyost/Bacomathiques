import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/expandable_widget.dart';
import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:bacomathiques/widgets/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a bubble (formula, tip, proof, ...).
class BubbleWidget extends ConsumerStatefulWidget {
  /// The bubble.
  final Bubble bubble;

  /// The bubble child.
  final Widget child;

  /// Whether to put its content in a scrollable view.
  final bool inScrollableView;

  /// Creates a new bubble widget instance.
  const BubbleWidget({
    required this.bubble,
    required this.child,
    required this.inScrollableView,
  });

  /// Creates a new bubble widget from a dom element.
  BubbleWidget.fromElement({
    required dom.Element element,
    required WidgetPlaceholder placeholder,
  }) : this(
          bubble: BubbleUtils.of(element),
          child: placeholder,
          inScrollableView: BubbleWidget._inScrollableView(element),
        );

  @override
  ConsumerState createState() => _BubbleWidgetState();

  /// Whether the widget should in a scrollable view.
  static bool _inScrollableView(dom.Element element) => element.getElementsByTagName('table').isNotEmpty || element.getElementsByTagName('pre').isNotEmpty;
}

/// The bubble widget state.
class _BubbleWidgetState extends ConsumerState<BubbleWidget> {
  /// The scroll controller, if enabled.
  ScrollController? scrollController;

  /// Whether to show the label.
  bool showLabel = false;

  @override
  void initState() {
    super.initState();
    if (widget.inScrollableView) {
      scrollController = ScrollController();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);
    BubbleTheme bubbleTheme = theme.bubbleThemes[widget.bubble]!;

    double width = MediaQuery.of(context).size.width;
    double padding = 20;
    Widget child = Padding(
      padding: EdgeInsets.all(padding),
      child: widget.child,
    );

    Widget bubbleWidget = GestureDetector(
      onTap: () {
        setState(() => showLabel = !showLabel);
      },
      child: Stack(
        children: [
          Container(
            width: width,
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
                ? Scrollbar(
                    thumbVisibility: true,
                    controller: scrollController,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: child,
                    ),
                  )
                : child,
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
}
