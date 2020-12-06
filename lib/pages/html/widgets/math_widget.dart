import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math/flutter_math.dart';

/// Allows to display some math.
class MathWidget extends StatelessWidget {
  /// The math content.
  final String content;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a new math widget instance.
  const MathWidget({
    @required this.content,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) => Math.tex(
        content,
        mathStyle: MathStyle.display,
        textStyle: textStyle.copyWith(color: textStyle.color ?? context.resolveTheme().textColor),
      );
}
