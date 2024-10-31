import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
                child: IgnorePointer(
                  ignoring: !isAboveDisplaying,
                  child: widget.above,
                ),
              ),
            ),
          ],
        ),
      );

  /// Toggles the current caption.
  void _toggleAbove() {
    setState(() => isAboveDisplaying = !isAboveDisplaying);
  }
}

/// A button above another widget.
class ButtonAboveWidget extends StatelessWidget {
  /// The target URL.
  final String url;

  /// The button.
  final String buttonText;

  /// The child.
  final Widget child;

  /// Creates a new button above widget instance.
  const ButtonAboveWidget({
    super.key,
    required this.url,
    required this.buttonText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => AboveWidgetFade(
        above: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.black.withAlpha(175)),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: OutlinedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.white),
              overlayColor: WidgetStateProperty.all(Colors.white24),
              side: WidgetStateProperty.all(const BorderSide(color: Colors.white)),
            ),
            onPressed: () async {
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url);
              }
            },
            child: Text(buttonText),
          ),
        ),
        under: child,
      );
}
