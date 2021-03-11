import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_tex_js/flutter_tex_js.dart';
import 'package:html/dom.dart' as dom;
import 'package:vector_math/vector_math_64.dart' show Vector3;

/// Allows to display some math.
class MathWidget extends StatelessWidget {
  /// The math content.
  final String content;

  /// The text style.
  final TextStyle textStyle;

  /// The render mode.
  final RenderMode renderMode;

  /// Creates a new math widget instance.
  const MathWidget({
    required this.content,
    this.textStyle = const TextStyle(),
    this.renderMode = RenderMode.FLUTTER_TEX_JS,
  });

  MathWidget.fromElement({
    required dom.Element element,
    required TextStyle textStyle,
  }) : this(content: element.text, textStyle: textStyle, renderMode: element.attributes['data-force-flutter-math-rendering'] == null ? RenderMode.FLUTTER_TEX_JS : RenderMode.FLUTTER_MATH);

  @override
  Widget build(BuildContext context) {
    if (renderMode == RenderMode.FLUTTER_TEX_JS) {
      return Container(
        transform: Matrix4.translation(Vector3(0, 6, 0)),
        child: TexImage(
          content,
          displayMode: false,
          color: textStyle.color,
          fontSize: textStyle.fontSize,
          alignment: Alignment.centerLeft,
          error: (context, error) => buildFlutterMathWidget(context),
        ),
      );
    }
    return buildFlutterMathWidget(context);
  }

  /// Builds the Flutter Math widget.
  Widget buildFlutterMathWidget(BuildContext context) {
    Math math = Math.tex(
      content,
      textStyle: textStyle.copyWith(color: textStyle.color ?? context.resolveTheme().textColor),
    );

    if (content.contains('\\lim')) {
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

/// Contains all available render mode.
enum RenderMode {
  /// Flutter Tex JS.
  FLUTTER_TEX_JS,

  /// Flutter math.
  FLUTTER_MATH
}
