import 'package:bacomathiques/app/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display some math.
class MathWidget extends ConsumerWidget {
  /// The math content.
  final String content;

  /// Whether to render in display mode.
  final bool displayStyle;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a new math widget instance.
  const MathWidget({
    required this.content,
    this.displayStyle = true,
    this.textStyle = const TextStyle(),
  });

  /// Creates a new math widget instance from the specified element.
  MathWidget.fromElement({
    required dom.Element element,
    required TextStyle textStyle,
  }) : this(
          content: element.text,
          displayStyle: element.attributes.containsKey('displaystyle'),
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Math math = Math.tex(
      content.replaceAll(r'\displaystyle', ''),
      mathStyle: displayStyle ? MathStyle.display : MathStyle.text,
      textStyle: textStyle.copyWith(color: textStyle.color ?? ref.watch(settingsModelProvider).resolveTheme(context).textColor),
    );

    List<Math> parts = math.texBreak().parts;
    return RichText(
      text: TextSpan(
        children: _handleParts(parts),
      ),
      textAlign: displayStyle ? TextAlign.center : TextAlign.start,
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
