import 'package:flutter/material.dart';

/// Allows to display a widget above another.
class AboveWidgetFade extends StatefulWidget {
  /// The widget that is under.
  final Widget under;

  /// The widget that is above.
  final Widget above;

  /// Creates a new above widget fade instance.
  const AboveWidgetFade({
    required this.under,
    required this.above,
  });

  @override
  State<StatefulWidget> createState() => _AboveWidgetFadeState();
}

/// The above widget fade state.
class _AboveWidgetFadeState extends State<AboveWidgetFade> {
  /// Whether the above widget is displaying.
  bool isAboveDisplaying = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _toggleAbove,
        child: Stack(
          children: [
            widget.under,
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: isAboveDisplaying ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: widget.above,
              ),
            ),
          ],
        ),
      );

  /// Toggles the current caption.
  void _toggleAbove() => setState(() {
        isAboveDisplaying = !isAboveDisplaying;
      });
}
