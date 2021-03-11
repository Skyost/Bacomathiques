import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/widgets/bubble_widget.dart';
import 'package:bacomathiques/pages/html/widgets/link_widget.dart';
import 'package:bacomathiques/pages/html/widgets/list_view_widget.dart';
import 'package:bacomathiques/pages/html/widgets/math_widget.dart';
import 'package:bacomathiques/pages/html/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_svg/fwfh_svg.dart';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory with SvgFactory {
  /// The list view tag build op.
  BuildOp? lv;

  /// The "scroll to this" global key.
  GlobalKey? scrollToThisKey;

  /// The a tag build op.
  BuildOp? a;

  /// The math tag build op.
  BuildOp? math;

  /// The formula tag build op.
  BuildOp? formula;

  /// The tip tag build op.
  BuildOp? tip;

  /// The proof tag build op.
  BuildOp? proof;

  /// The H4 tag build op.
  BuildOp? h4;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a new app widget factory instance.
  AppWidgetFactory({
    required this.textStyle,
  });

  @override
  void parse(BuildMetadata meta) {
    super.parse(meta);
    if (meta.element.localName == 'lv') {
      String? scrollTarget = meta.element.attributes['data-scroll-target']?.substring(1);
      lv ??= BuildOp(
        onChild: scrollTarget == null || scrollToThisKey != null
            ? null
            : (meta) {
                if (meta.element.id == scrollTarget) {
                  scrollToThisKey = GlobalKey();
                  meta.register(
                    BuildOp(
                      onWidgets: (meta, children) => [
                        SizedBox.shrink(key: scrollToThisKey),
                        ...children,
                      ],
                    ),
                  );
                }
              },
        onWidgets: (meta, children) => [
          ListViewWidget(
            scrollToThisKey: scrollToThisKey,
            children: children.toList(),
          ),
        ],
      );
      meta.register(lv!);
    } else if (meta.element.localName == 'a') {
      a ??= BuildOp(
        onTree: (meta, tree) => tree.replaceWith(
          WidgetBit.inline(
            tree,
            LinkWidget.fromElement(
              element: meta.element,
              fontSize: textStyle.fontSize!,
            ),
          ),
        ),
      );
      meta.register(a!);
    } else if (meta.element.localName == 'math') {
      math ??= BuildOp(
        onTree: (meta, tree) => tree.replaceWith(
          WidgetBit.inline(
            tree,
            MathWidget.fromElement(
              element: meta.element,
              textStyle: textStyle,
            ),
          ),
        ),
      );
      meta.register(math!);
    } else if (meta.element.classes.contains(Bubble.FORMULA.className)) {
      formula ??= _createBubbleBuildOp(Bubble.FORMULA, meta);
      meta.register(formula!);
    } else if (meta.element.classes.contains(Bubble.TIP.className)) {
      tip ??= _createBubbleBuildOp(Bubble.TIP, meta);
      meta.register(tip!);
    } else if (meta.element.classes.contains(Bubble.PROOF.className)) {
      proof ??= _createBubbleBuildOp(Bubble.PROOF, meta);
      meta.register(proof!);
    } else if (meta.element.localName == 'h4') {
      h4 ??= BuildOp(
        onTree: (meta, tree) => tree.replaceWith(
          WidgetBit.block(tree, TitleWidget.fromElement(element: meta.element)),
        ),
      );
      meta.register(h4!);
    }
  }

  @override
  String getListStyleMarker(String type, int i) {
    if (type == 'dash') {
      return '— ';
    }
    return super.getListStyleMarker(type, i);
  }

  /// Creates a bubble build op.
  BuildOp _createBubbleBuildOp(Bubble bubble, BuildMetadata meta) => BuildOp(
        onChild: (meta) {
          if (meta.element.localName == 'h4' || meta.element.localName == 'a') {
            meta.element.attributes['data-parent-bubble'] = bubble.className;
          }
        },
        onWidgets: (meta, children) => [
          BubbleWidget.fromElement(
            element: meta.element,
            children: children.toList(),
          ),
        ],
      );
}
