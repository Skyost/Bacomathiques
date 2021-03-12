
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

  /// Whether to force breaks.
  final bool forceBreak;

  /// Creates a new math widget instance.
  MathWidget({
    required this.content,
    this.textStyle = const TextStyle(),
    this.forceBreak = false,
  });

  /// Creates a new math widget instance from the specified element.
  MathWidget.fromElement({
    required dom.Element element,
    required TextStyle textStyle,
  }) : this(
          content: element.text,
          textStyle: textStyle,
          forceBreak: element.attributes['data-force-break'] == 'true'
        );

  @override
  Widget build(BuildContext context) {
    Math math = Math.tex(
      content,
      textStyle: textStyle.copyWith(color: textStyle.color ?? context.resolveTheme().textColor),
    );

    if (!forceBreak || content.contains('\\lim')) {
      return math;
    }

    List<Math> parts = math.texBreak().parts;
    if (parts.length == 1) {
      return parts.first;
    }

    return Wrap(
      spacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: parts,
    );
  }
}
