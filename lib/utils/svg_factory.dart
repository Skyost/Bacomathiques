import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:jovial_svg/jovial_svg.dart';

const kAttributeSvgHeight = 'height';
const kAttributeSvgWidth = 'width';
const kTagSvg = 'svg';

/// A mixin that can render SVG with `flutter_svg` plugin.
mixin SvgFactory on WidgetFactory {
  BuildOp? _tagSvg;

  /// Controls whether the SVG can be drawn outside
  /// of the clip boundary of its view box.
  /// See [SvgPicture.allowDrawingOutsideViewBox] for more information.
  ///
  /// Default: `false`.
  bool get svgAllowDrawingOutsideViewBox => false;

  @override
  Widget? buildImageWidget(BuildTree meta, ImageSource src) {
    final url = src.url;
    Uri? uri = Uri.tryParse(url);

    ScalableImageSource? scalableImageSource;
    if (url.startsWith('data:image/svg+xml')) {
      if (uri != null) {
        scalableImageSource = ScalableImageSource.fromSvgHttpUrl(uri);
      }
    } else if (uri?.path.toLowerCase().endsWith('.svg') == true) {
      if (url.startsWith('asset:')) {
        scalableImageSource = imageSvgFromAsset(url);
      } else if (url.startsWith('file:')) {
        scalableImageSource = imageSvgFromFileUri(url);
      } else {
        scalableImageSource = imageSvgFromNetwork(url);
      }
    }

    if (scalableImageSource == null) {
      return super.buildImageWidget(meta, src);
    }

    return _buildSvgPicture(meta, src, scalableImageSource);
  }

  /// Returns a [ScalableImageSource].
  ScalableImageSource? imageSvgFromAsset(String url) {
    final uri = Uri.parse(url);
    final assetName = uri.path;
    if (assetName.isEmpty) {
      return null;
    }

    return ScalableImageSource.fromSvg(rootBundle, uri.queryParameters['package']!);
  }

  /// Returns a [ScalableImageSource].
  ScalableImageSource? imageSvgFromFileUri(String url) {
    final filePath = Uri.parse(url).toFilePath();
    if (filePath.isEmpty) {
      return null;
    }
    File file = File(filePath);
    if (!file.existsSync()) {
      return null;
    }

    return ScalableImageSource.fromSvgFile(file, () => file.readAsString());
  }

  /// Returns a [ScalableImageSource].
  ScalableImageSource? imageSvgFromNetwork(String url) {
    if (url.isEmpty) {
      return null;
    }
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    return ScalableImageSource.fromSvgHttpUrl(uri);
  }

  @override
  void parse(BuildTree meta) {
    switch (meta.element.localName) {
      case kTagSvg:
        meta.register(
          _tagSvg ??= BuildOp(
            // TODO: set debugLabel when our minimum core version >= 1.0
            defaultStyles: (element) {
              // other tags that share the same logic:
              // - IFRAME
              // - IMG
              //
              // consider update them together if this changes
              final attrs = element.attributes;
              final height = attrs[kAttributeSvgHeight];
              final width = attrs[kAttributeSvgWidth];

              return {
                'height': 'auto',
                'min-width': '0px',
                'min-height': '0px',
                'width': 'auto',
                if (height != null) 'height': height,
                if (width != null) 'width': width,
              };
            },
            onRenderBlock: (tree, placeholder) {
              final source = ScalableImageSource.fromSvgFile(meta.element.outerHtml, () => meta.element.outerHtml);
              const src = ImageSource('');
              final built = _buildSvgPicture(meta, src, source);
              return built;
            },
          ),
        );
        break;
    }

    return super.parse(meta);
  }

  Widget _buildSvgPicture(
    BuildTree meta,
    ImageSource src,
    ScalableImageSource source,
  ) {
    final image = src.image;
    final semanticLabel = image?.alt ?? image?.title;

    return SizedBox(
      height: src.height,
      width: src.width,
      child: ScalableImageWidget.fromSISource(
        si: source,
        clip: !svgAllowDrawingOutsideViewBox,
        fit: BoxFit.scaleDown,
        onLoading: (context) {
          final loading = onLoadingBuilder(context, meta, null, src);
          if (loading != null) {
            return loading;
          }

          if (src.width != null && src.height != null) {
            return SizedBox(width: src.width, height: src.height);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
