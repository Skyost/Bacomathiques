import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// A build bit that allows to display some math.
class MathBit extends BuildBit {
  /// The parent build bit.
  @override
  final BuildTree parent;

  /// The math content.
  final String math;

  /// The text style.
  final TextStyle? textStyle;

  /// Whether the math should be in display style.
  final bool displayStyle;

  /// Creates a new math bit instance.
  const MathBit({
    required this.parent,
    required this.math,
    this.textStyle,
    this.displayStyle = false,
  });

  @override
  void flatten(Flattened f) {
    Math math = Math.tex(
      this.math,
      textStyle: textStyle?.copyWith(fontSize: textStyle?.fontSize),
      mathStyle: displayStyle ? MathStyle.display : MathStyle.text,
      settings: TexParserSettings(
        macros: {
          '\\tag': MacroDefinition.fromString("\\qquad (#1)"),
        },
      ),
    );
    List<Widget> parts = math.texBreak().parts;
    if (displayStyle) {
      parts = parts
          .map(
            (child) => FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: child,
            ),
          )
          .toList();
    }
    for (int i = 0; i < parts.length; i++) {
      f.inlineWidget(
        baseline: TextBaseline.alphabetic,
        alignment: PlaceholderAlignment.baseline,
        child: parts[i],
      );
      if (i < parts.length - 1) {
        f.write(text: ' ');
      }
    }
  }

  @override
  MathBit copyWith({
    BuildTree? parent,
    String? math,
    TextStyle? textStyle,
    bool? displayStyle,
  }) =>
      MathBit(
        parent: parent ?? this.parent,
        math: math ?? this.math,
        textStyle: textStyle ?? this.textStyle,
        displayStyle: displayStyle ?? this.displayStyle,
      );
}
