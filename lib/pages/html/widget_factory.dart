import 'package:bacomathiques/model/api/common.dart';
import 'package:bacomathiques/pages/html/math_bit.dart';
import 'package:bacomathiques/utils/svg_factory.dart';
import 'package:bacomathiques/widgets/fade_stack_widget.dart';
import 'package:bacomathiques/widgets/html/bubble_widget.dart';
import 'package:bacomathiques/widgets/theme/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

const _tagH2 = 'h2';
const _tagH3 = 'h3';
const _tagH4 = 'h4';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory with SvgFactory {
  /// The text style.
  final BuildContext context;

  /// Creates a new app widget factory instance.
  AppWidgetFactory({
    required this.context,
  });

  @override
  void parse(BuildTree tree) {
    if (tree.element.localName == 'math' || tree.element.localName == 'latex') {
      _registerMathOp(tree);
      return;
    }

    for (Bubble bubble in Bubble.values) {
      if (tree.element.classes.contains(bubble.className)) {
        _registerBubbleBuildOp(bubble, tree);
        return;
      }
    }

    if (tree.element.localName == _tagH2 || tree.element.localName == _tagH3 || tree.element.localName == _tagH4) {
      _registerTitleBuildOps(tree);
      return;
    }

    super.parse(tree);
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
    super.parse(meta);
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
