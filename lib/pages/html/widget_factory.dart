import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/pages/html/math_bit.dart';
import 'package:bacomathiques/utils/svg_factory.dart';
import 'package:bacomathiques/widgets/fade_stack_widget.dart';
import 'package:bacomathiques/widgets/html/bubble_widget.dart';
import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_widget_from_html_core/src/internal/core_ops.dart';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory with SvgFactory {
  /// The text style.
  final BuildContext context;

  /// Creates a new app widget factory instance.
  AppWidgetFactory({
    required this.context,
  });

  @override
  void parse(BuildTree meta) {
    if (meta.element.localName == 'math' || meta.element.localName == 'latex') {
      _registerMathOp(meta);
      return;
    }

    for (Bubble bubble in Bubble.values) {
      if (meta.element.classes.contains(bubble.className)) {
        _registerBubbleBuildOp(bubble, meta);
        return;
      }
    }

    if (meta.element.localName == kTagH2 || meta.element.localName == kTagH3 || meta.element.localName == kTagH4) {
      _registerTitleBuildOps(meta);
      return;
    }

    super.parse(meta);
  }

  @override
  String getListMarkerText(String type, int i) {
    String result = super.getListMarkerText(type, i);
    return result.isEmpty ? type : result;
  }

  @override
  Widget? buildImage(BuildTree tree, ImageMetadata data) {
    String? url;
    for (ImageSource source in data.sources) {
      if (source.url.startsWith(API.baseUrl)) {
        url = source.url;
      }
    }
    Widget? result = super.buildImage(tree, data);
    return url == null || result == null
        ? result
        : ButtonAboveWidget(
            url: url,
            buttonText: 'Ouvrir dans le navigateur',
            child: result,
          );
  }

  /// Creates and registers the math build op.
  void _registerMathOp(BuildTree meta) {
    BuildOp math = BuildOp.v2(
      onParsed: (tree) {
        BuildTree newTree = tree.parent.sub();
        String math = '';
        for (BuildBit bit in tree.bits.toList(growable: false)) {
          if (bit is TextBit) {
            math += bit.data;
          }
        }
        for (BuildBit bit in tree.bits.toList(growable: false)) {
          if (bit is TextBit) {
            if (math.isNotEmpty) {
              newTree.append(MathBit(
                parent: tree,
                math: math,
                textStyle: tree.inheritanceResolvers.resolve(context).prepareTextStyle().copyWith(fontWeight: FontWeight.normal),
                displayStyle: meta.element.attributes.containsKey('displaystyle'),
              ));
              math = '';
            }
          } else {
            newTree.append(bit);
          }
        }
        return newTree;
      },
    );
    meta.register(math);
  }

  /// Creates and registers title build ops.
  void _registerTitleBuildOps(BuildTree meta) {
    BuildOp headline = const BuildOp.v2();
    meta.register(headline);
    if (meta.element.attributes.containsKey(kAttributeId)) {
      meta.register(Anchor(this, meta.element.attributes[kAttributeId]!).buildOp);
    }
  }

  /// Creates and register a bubble build op.
  void _registerBubbleBuildOp(Bubble bubble, BuildTree meta) {
    BuildOp bubbleBuildOp = BuildOp.v2(
      onRenderBlock: (tree, placeholder) => BubbleWidget.fromElement(
        element: tree.element,
        placeholder: placeholder,
      ),
    );
    meta.register(bubbleBuildOp);
  }
}
