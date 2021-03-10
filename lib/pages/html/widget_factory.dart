import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/pages/html/widgets/bubble_widget.dart';
import 'package:bacomathiques/pages/html/widgets/link_widget.dart';
import 'package:bacomathiques/pages/html/widgets/list_view_widget.dart';
import 'package:bacomathiques/pages/html/widgets/math_widget.dart';
import 'package:bacomathiques/pages/html/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// Allows to display custom widgets to the HTML content.
class AppWidgetFactory extends WidgetFactory {
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
      meta.register(lv);
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
      meta.register(a);
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
      meta.register(math);
    } else if (meta.element.classes.contains(Bubble.FORMULA.className)) {
      formula ??= _createBubbleBuildOp(Bubble.FORMULA, meta);
      meta.register(formula);
    } else if (meta.element.classes.contains(Bubble.TIP.className)) {
      tip ??= _createBubbleBuildOp(Bubble.TIP, meta);
      meta.register(tip);
    } else if (meta.element.classes.contains(Bubble.PROOF.className)) {
      proof ??= _createBubbleBuildOp(Bubble.PROOF, meta);
      meta.register(proof);
    } else if (meta.element.localName == 'h4') {
      h4 ??= BuildOp(
        onTree: (meta, tree) => tree.replaceWith(
          WidgetBit.block(tree, TitleWidget.fromElement(element: meta.element)),
        ),
      );
      meta.register(h4);
    }
  }

  @override
  Widget? buildImage(BuildMetadata meta, Object provider, ImageMetadata? data) {
    Widget? built = super.buildImage(meta, provider, data) as Widget?;

    if (built == null && provider is PictureProvider) {
      built = SvgPicture(
        provider,
        semanticsLabel: data?.alt ?? data?.title,
        height: double.tryParse(meta.element.attributes['height'] ?? 'null'),
        width: double.tryParse(meta.element.attributes['width'] ?? 'null'),
      );
    }

    if (data?.title != null && built != null) {
      built = Tooltip(
        message: data!.title,
        child: built,
      );
    }

    return built;
  }

  @override
  String getListStyleMarker(String type, int i) {
    if (type == 'dash') {
      return '— ';
    }
    return super.getListStyleMarker(type, i);
  }

  @override
  Object? imageProvider(ImageSource? imgSrc) {
    String? url = imgSrc?.url;
    if (url != null && (Uri.tryParse(url)?.path.toLowerCase().endsWith('.svg') == true)) {
      return _imageSvgPictureProvider(url);
    }

    return super.imageProvider(imgSrc);
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

  /// Builds a picture provider from the specified url.
  PictureProvider? _imageSvgPictureProvider(String? url) {
    if (url?.startsWith('asset:') == true) {
      Uri? uri = url?.isNotEmpty == true ? Uri.tryParse(url ?? '') : null;
      if (uri?.scheme != 'asset') {
        return null;
      }

      String assetName = uri!.path;
      if (assetName.isNotEmpty != true) {
        return null;
      }

      return ExactAssetPicture(
        SvgPicture.svgStringDecoder,
        assetName,
        package: uri.queryParameters.containsKey('package') == true ? uri.queryParameters['package'] : null,
      );
    }

    return NetworkPicture(SvgPicture.svgByteDecoder, url);
  }
}
