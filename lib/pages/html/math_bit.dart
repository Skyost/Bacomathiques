import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// A build bit that allows to display some math.
class MathBit extends BuildBit<void, InlineSpan> {
  /// The math content.
  final String math;

  /// The text style.
  final TextStyle? textStyle;

  /// Whether the math should be in display style.
  final bool displayStyle;

  /// Creates a new math bit instance.
  const MathBit({
    BuildTree? parent,
    required TextStyleBuilder tsb,
    required this.math,
    this.textStyle,
    this.displayStyle = false,
  }) : super(parent, tsb);

  @override
  InlineSpan buildBit(void input) {
    Math math = Math.tex(
      this.math.replaceAll(r'\displaystyle', ''),
      textStyle: textStyle?.copyWith(fontSize: textStyle?.fontSize),
      mathStyle: displayStyle ? MathStyle.display : MathStyle.text,
    );
    List<Math> parts = math.texBreak().parts;
    List<InlineSpan> children = [];
    for (Math part in parts) {
      children.add(WidgetSpan(
        baseline: TextBaseline.alphabetic,
        alignment: PlaceholderAlignment.baseline,
        child: part,
      ));
      children.add(const TextSpan(text: ' '));
    }
    children.removeLast();

    // if (displayStyle) {
    //   return WidgetSpan(
    //     child: RichText(
    //       text: TextSpan(children: children),
    //       textAlign: TextAlign.center,
    //     ),
    //   );
    // }

    return TextSpan(
      children: children,
    );
  }

  @override
  MathBit copyWith({
    BuildTree? parent,
    TextStyleBuilder? tsb,
    String? math,
    TextStyle? textStyle,
    bool? displayStyle,
  }) =>
      MathBit(
        parent: parent ?? this.parent,
        tsb: tsb ?? this.tsb,
        math: math ?? this.math,
        textStyle: textStyle ?? this.textStyle,
        displayStyle: displayStyle ?? this.displayStyle,
      );
}
