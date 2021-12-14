import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/widgets/bubble_widget.dart';
import 'package:bacomathiques/pages/html/widgets/link_widget.dart';
import 'package:bacomathiques/pages/html/widgets/list_view_widget.dart';
import 'package:bacomathiques/pages/html/widgets/math_widget.dart';
import 'package:bacomathiques/pages/html/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_svg/fwfh_svg.dart';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory with SvgFactory {
  /// The "scroll to this" global key.
  GlobalKey? scrollToThisKey;

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
      String? scrollTarget = meta.element.attributes['data-scroll-target'];
      BuildOp lv = BuildOp(
        onChild: scrollTarget == null || scrollToThisKey != null
            ? null
            : (meta) {
          if (meta.element.id == scrollTarget) {
            scrollToThisKey = GlobalKey();
            meta.register(
              BuildOp(
                onWidgets: (meta, children) => [
                  ScrollToThis(scrollToThisKey!),
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
      meta.register(lv);
    } else if (meta.element.localName == 'a') {
      BuildOp a = BuildOp(
        onTree: (meta, tree) {
          while(tree.first != null) {
            tree.first?.detach();
          }
          tree.add(
            WidgetBit.inline(
              tree,
              LinkWidget.fromElement(
                element: meta.element,
                fontSize: textStyle.fontSize!,
              ),
            ),
          );
        }
      );
      meta.register(a);
    } else if (meta.element.localName == 'math') {
      BuildOp math = BuildOp(
        onTree: (meta, tree) {
          while(tree.first != null) {
            tree.first?.detach();
          }
          tree.add(
            WidgetBit.inline(
              tree,
              MathWidget.fromElement(
                element: meta.element,
                textStyle: textStyle,
              ),
            ),
          );
        },
      );
      meta.register(math);
    } else if (meta.element.classes.contains(Bubble.FORMULA.className)) {
      meta.register(_createBubbleBuildOp(Bubble.FORMULA, meta));
    } else if (meta.element.classes.contains(Bubble.TIP.className)) {
      meta.register(_createBubbleBuildOp(Bubble.TIP, meta));
    } else if (meta.element.classes.contains(Bubble.PROOF.className)) {
      meta.register(_createBubbleBuildOp(Bubble.PROOF, meta));
    } else if (meta.element.localName == 'h2') {
      meta.register(_createTitleBuildOp(meta));
    } else if (meta.element.localName == 'h3') {
      meta.register(_createTitleBuildOp(meta));
    } else if (meta.element.localName == 'h4') {
      meta.register(_createTitleBuildOp(meta));
    }
  }

  @override
  String getListMarkerText(String type, int i) {
    if (type == 'dash') {
      return '— ';
    }
    return super.getListMarkerText(type, i);
  }

  /// Creates a title build op.
  BuildOp _createTitleBuildOp(BuildMetadata meta) => BuildOp(
        onTree: (meta, tree) {
          while(tree.first != null) {
            tree.first?.detach();
          }
          tree.add(
            WidgetBit.block(tree, TitleWidget.fromElement(element: meta.element)),
          );
        },
      );

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
