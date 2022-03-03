import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/pages/html/html_widget.dart';
import 'package:bacomathiques/pages/html/math_bit.dart';
import 'package:bacomathiques/pages/html/widgets/bubble_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_svg/fwfh_svg.dart';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory with SvgFactory {
  /// The text style.
  final TextStyle textStyle;

  /// The app theme.
  final AppTheme appTheme;

  /// Creates a new app widget factory instance.
  AppWidgetFactory({
    required this.textStyle,
    required this.appTheme,
  });

  @override
  void parse(BuildMetadata meta) {
    if (meta.element.localName != 'h2' && meta.element.localName != 'h3' && meta.element.localName != 'h4') {
      super.parse(meta);
    }
    if (meta.element.localName == 'math') {
      BuildOp math = BuildOp(
        onTree: (meta, tree) {
          for (BuildBit bit in tree.bits.toList(growable: false)) {
            if (bit is TextBit) {
              MathBit(
                parent: bit.parent,
                tsb: bit.tsb,
                math: bit.data,
                textStyle: textStyle,
                displayStyle: meta.element.attributes.containsKey('displaystyle'),
              ).insertAfter(bit);
              bit.detach();
            }
          }
        },
      );
      meta.register(math);
    } else if (meta.element.classes.contains(Bubble.formula.className)) {
      meta.register(_createBubbleBuildOp(Bubble.formula, meta));
    } else if (meta.element.classes.contains(Bubble.tip.className)) {
      meta.register(_createBubbleBuildOp(Bubble.tip, meta));
    } else if (meta.element.classes.contains(Bubble.proof.className)) {
      meta.register(_createBubbleBuildOp(Bubble.proof, meta));
    } else if (meta.element.localName == 'h2') {
      _registerTitleBuildOps(meta);
    } else if (meta.element.localName == 'h3') {
      _registerTitleBuildOps(meta);
    } else if (meta.element.localName == 'h4') {
      _registerTitleBuildOps(meta);
    }
  }

  @override
  Widget? buildText(BuildMetadata meta, TextStyleHtml tsh, InlineSpan text) {
    TextStyleHtml textStyleHtml = tsh;
    if (meta.element.classes.contains('katex-display')) {
      textStyleHtml = textStyleHtml.copyWith(textAlign: TextAlign.center);
    }
    return super.buildText(meta, textStyleHtml, text);
  }

  @override
  String getListMarkerText(String type, int i) {
    if (type == 'dash') {
      return '— ';
    }
    return super.getListMarkerText(type, i);
  }

  /// Creates and registers title build ops.
  void _registerTitleBuildOps(BuildMetadata meta) {
    BuildOp headline = BuildOp(
      onTree: (meta, tree) {
        for (BuildBit bit in tree.bits.toList(growable: false)) {
          if (bit is MathBit) {
            bit
                .copyWith(
                  textStyle: TextStyle(
                    color: AppHtmlWidget.getHeadlineColor(appTheme, meta.element),
                    fontSize: AppHtmlWidget.getHeadlineFontSize(appTheme, meta.element),
                  ),
                )
                .insertAfter(bit);
            bit.detach();
          }
        }
      },
    );
    meta.register(headline);
    if (meta.element.attributes.containsKey('id')) {
      meta.register(_anchorOp(meta.element.attributes['id']!));
    }
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

  /// Taken from the super method.
  BuildOp _anchorOp(String id) {
    final anchor = GlobalKey(debugLabel: id);

    return BuildOp(
      onTree: (meta, tree) {
        anchorRegistry.register(id, anchor);
        tree.registerAnchor(anchor);
      },
      onTreeFlattening: (meta, tree) {
        final widget = WidgetPlaceholder('#$id').wrapWith(
          (context, _) => SizedBox(
            height: meta.tsb.build(context).style.fontSize,
            key: anchor,
          ),
        );

        final bit = tree.first;
        if (bit == null) {
          // most likely an A[name]
          tree.add(
            WidgetBit.inline(
              tree,
              widget,
              alignment: PlaceholderAlignment.baseline,
            ),
          );
        } else {
          // most likely a SPAN[id]
          WidgetBit.inline(
            bit.parent!,
            widget,
            alignment: PlaceholderAlignment.baseline,
          ).insertBefore(bit);
        }
      },
      onWidgets: (meta, widgets) {
        return listOrNull(
          buildColumnPlaceholder(meta, widgets)?.wrapWith(
            (context, child) => SizedBox(key: anchor, child: child),
          ),
        );
      },
      onWidgetsIsOptional: true,
      priority: BuildOp.kPriorityMax,
    );
  }
}
