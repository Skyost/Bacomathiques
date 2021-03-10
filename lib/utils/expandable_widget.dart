import 'package:flutter/material.dart';

/// Allows to show an expandable widget.
class Expandable extends StatefulWidget {
  /// The expand text.
  final String expandText;

  /// The expand text style.
  final TextStyle expandTextStyle;

  /// The expanded content.
  final Widget content;

  /// Creates a new expandable widget instance.
  const Expandable({
    required this.expandText,
    required this.expandTextStyle,
    required this.content,
  });

  @override
  State<StatefulWidget> createState() => _ExpandableState();
}

/// The expandable state.
class _ExpandableState extends State<Expandable> {
  /// Whether this widget is expanded.
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    Widget expandButton = Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          setState(() => expanded = !expanded);
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CustomPaint(
                size: Size.square((widget.expandTextStyle.fontSize ?? 14) - 4),
                painter: _CaretPainter(
                  color: widget.expandTextStyle.color!,
                  expanded: expanded,
                ),
              ),
            ),
            Text(
              widget.expandText,
              textAlign: TextAlign.right,
              style: widget.expandTextStyle,
            ),
          ],
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

/// Paints a caret.
class _CaretPainter extends CustomPainter {
  /// The color.
  final Color color;

  /// Whether the widget is expanded.
  final bool expanded;

  /// Creates a new caret painter instance.
  const _CaretPainter({
    required this.color,
    required this.expanded,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    // paint.isAntiAlias = true;

    Path path = Path();
    if (expanded) {
      drawExpandedCaret(path, size);
    } else {
      drawCaret(path, size);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CaretPainter oldDelegate) => oldDelegate.color != color || oldDelegate.expanded != expanded;

  /// Draws the expanded caret.
  void drawExpandedCaret(Path path, Size size) {
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
  }

  /// Draw the (non-expanded) caret.
  void drawCaret(Path path, Size size) {
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, 0);
  }
}
