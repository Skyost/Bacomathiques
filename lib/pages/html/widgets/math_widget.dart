import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display some math.
class MathWidget extends StatelessWidget {
  /// The math content.
  final String content;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a new math widget instance.
  const MathWidget({
    required this.content,
    this.textStyle = const TextStyle(),
  });

  /// Creates a new math widget instance from the specified element.
  MathWidget.fromElement({
    required dom.Element element,
    required TextStyle textStyle,
  }) : this(
          content: element.text,
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context) {
    Math math = Math.tex(
      content.replaceAll(r'\displaystyle', ''),
      textStyle: textStyle.copyWith(color: textStyle.color ?? context.resolveTheme().textColor),
    );

    List<Math> parts = math.texBreak().parts;
    return RichText(
      text: TextSpan(
        children: _handleParts(parts),
      ),
    );
  }

  /// Handles the math parts.
  List<InlineSpan> _handleParts(List<Math> parts) {
    List<InlineSpan> result = [];
    for (Math part in parts) {
      result.add(WidgetSpan(
        baseline: TextBaseline.alphabetic,
        alignment: PlaceholderAlignment.baseline,
        child: part,
      ));
      result.add(const TextSpan(
        text: ' ',
      ));
    }
    // result.removeLast();
    return result;
  }
}
