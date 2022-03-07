import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/pages/html/widget_factory.dart';
import 'package:bacomathiques/pages/html/widgets/representation_preview_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

/// Allows to display a HTML widget.
class AppHtmlWidget extends ConsumerStatefulWidget {
  /// The HTML data.
  final String data;

  /// The anchor.
  final String? anchor;

  /// Creates a new app HTML widget instance.
  const AppHtmlWidget({
    required this.data,
    this.anchor,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppHtmlWidgetState();

  /// Returns the headline color.
  static Color? getHeadlineColor(AppTheme theme, dom.Element headline) {
    if (headline.localName == 'h2') {
      return theme.h2Color ?? theme.textColor;
    } else if (headline.localName == 'h3') {
      return theme.h3Color ?? theme.textColor;
    } else if (headline.localName == 'h4') {
      Bubble bubble = BubbleUtils.getByClassName(headline.attributes['data-parent-bubble']);
      return theme.bubbleThemes[bubble]?.leftBorderColor;
    }
    return theme.textColor;
  }

  /// Returns the headline font size.
  static double getHeadlineFontSize(AppTheme theme, dom.Element headline) {
    if (headline.localName == 'h2') {
      return theme.h2Size;
    } else if (headline.localName == 'h3') {
      return theme.h3Size;
    } else if (headline.localName == 'h4') {
      return theme.h4Size;
    }
    return 16;
  }
}

/// The html widget state.
class _AppHtmlWidgetState extends ConsumerState<AppHtmlWidget> {
  /// The HTML widget key.
  GlobalKey<HtmlWidgetState> htmlWidgetKey = GlobalKey<HtmlWidgetState>();

  @override
  void initState() {
    super.initState();
    if (widget.anchor != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        // await Future.delayed(const Duration(milliseconds: 500));
        htmlWidgetKey.currentState?.scrollToAnchor(widget.anchor!); // TODO: Doesn't work because the widget is not loaded yet.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyTextStyle = Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16);
    AppTheme theme = ref.watch(settingsModelProvider).resolveTheme(context);

    return HtmlWidget(
      widget.data,
      key: htmlWidgetKey,
      buildAsync: true,
      customWidgetBuilder: buildCustomWidget,
      customStylesBuilder: (element) => buildCustomStyle(context, theme, element),
      onLoadingBuilder: (context, element, progress) {
        String message = 'Rendu…';
        if (progress != null) {
          message += '\n' + progress.toString() + '%';
        }
        return CenteredCircularProgressIndicator(message: message);
      },
      onErrorBuilder: (context, element, error) {
        if (kDebugMode) {
          print(element);
        }
        String title = error == null ? 'Erreur' : 'Erreur "${error.toString()}"';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Text(
              '$title. Veuillez réessayer plus tard.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
      },
      //rebuildTriggers: RebuildTriggers([data, buildCustomWidget, buildCustomStyle]),
      textStyle: bodyTextStyle,
      factoryBuilder: () => AppWidgetFactory(textStyle: bodyTextStyle, appTheme: theme),
      renderMode: const ListViewMode(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
      ),
      onTapUrl: (url) async {
        if (url.startsWith('#')) {
          return false;
        }

        Uri uri = Uri.parse(url);
        if (uri.host != Uri.parse(API.baseUrl).host || uri.pathSegments.length < 3 || uri.pathSegments.first != 'cours') {
          if (await canLaunch(url)) {
            await launch(url);
          }
          return true;
        }

        LessonContentEndpoint endpoint = LessonContentEndpoint.fromLevelAndLesson(
          level: uri.pathSegments[1],
          lesson: uri.pathSegments[2],
        );
        await Navigator.pushReplacementNamed(context, '/html', arguments: {'endpoint': endpoint, 'anchor': uri.fragment});
        return true;
      },
    );
  }

  /// Builds the widget of an element.
  Widget? buildCustomWidget(dom.Element element) {
    if (element.attributes.containsKey('data-api-v2-geogebra-image') && element.attributes.containsKey('data-api-v2-geogebra-id')) {
      return RepresentationPreviewWidget(
        imageURL: element.attributes['data-api-v2-geogebra-image']!,
        geogebraId: element.attributes['data-api-v2-geogebra-id']!,
      );
    }

    return null;
  }

  /// Builds the style of an element.
  Map<String, String>? buildCustomStyle(BuildContext context, AppTheme theme, dom.Element element) {
    Map<String, String> style = {
      if (element.classes.contains('mb-0')) 'margin-bottom': '0',
      if (element.classes.contains('katex-display')) 'display': 'block',
      if (element.classes.contains('center')) 'text-align': 'center',
    };

    switch (element.localName) {
      case 'h2':
      case 'h3':
      case 'h4':
        Color? color = AppHtmlWidget.getHeadlineColor(theme, element);
        double fontSize = AppHtmlWidget.getHeadlineFontSize(theme, element);
        double paddingBottom = 0;
        double marginBottom = 0;
        String? borderBottom;
        if (element.localName == 'h2') {
          borderBottom = '1px solid ${(theme.hrColor ?? Colors.white).toHex()}';
          paddingBottom = 8;
          marginBottom = 14;
        } else if (element.localName == 'h3') {
          marginBottom = 13;
        } else if (element.localName == 'h4') {
          marginBottom = 12;
        }
        return {
          'display': 'block',
          'font-size': '${fontSize}px',
          'color': (color ?? Colors.black).toHex(),
          if (borderBottom != null) 'border-bottom': borderBottom,
          'padding-bottom': '${paddingBottom}px',
          'margin-bottom': '${marginBottom}px',
          // 'font-weight': '0',
          'font-family': 'FuturaBT',
          'margin-top': '0',
          'padding-top': '0',
          ...style,
        };
      case 'p':
        return {
          'margin-top': '0',
          'padding-top': '0',
          ...style,
        };
      case 'ol':
        {
          return {
            'margin-top': '0',
            'margin-bottom': '0',
            'padding-left': '2em',
            ...style,
          };
        }
      case 'ul':
        return {
          'list-style-type': 'dash',
          'margin-top': '0',
          'margin-bottom': '0',
          'padding-left': '2em',
          ...style,
        };
      case 'li':
        return {
          'margin-bottom': '0.8em',
          ...style,
        };
      case 'table':
        return {
          'background-color': theme.brightness == Brightness.light ? 'white' : 'transparent',
          'border': '0.5px solid #cfcfcf',
          ...style,
        };
      case 'th':
        return {
          'padding': '10px',
          'border-top': '0.5px solid #cfcfcf',
          'border-right': '0.5px solid #cfcfcf',
          'border-left': '0.5px solid #cfcfcf',
          'border-bottom': '1px solid #cfcfcf',
          ...style,
        };
      case 'td':
        return {
          'padding': '10px',
          'border': '0.5px solid #cfcfcf',
          ...style,
        };
      case 'img':
        return {
          'max-height': '150px',
          ...style,
        };
      case 'a':
        {
          Bubble bubble = BubbleUtils.getByClassName(element.attributes['data-parent-bubble']);
          return {
            'color': theme.bubbleThemes[bubble]!.linkColor.toHex(),
            'text-decoration-color': theme.bubbleThemes[bubble]!.linkDecorationColor.toHex(),
            ...style,
          };
        }
    }

    return null;
  }
}
