import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/pages/html/widget_factory.dart';
import 'package:bacomathiques/pages/html/widgets/representation_preview_widget.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html/dom.dart' as dom;

/// Allows to display a HTML widget.
class AppHtmlWidget extends StatelessWidget {
  /// The HTML data.
  final String data;

  /// The text style.
  final TextStyle textStyle;

  /// Whether to build it async.
  final bool buildAsync;

  /// Creates a new app HTML widget instance.
  const AppHtmlWidget({
    required this.data,
    required this.textStyle,
    this.buildAsync = true,
  });

  @override
  Widget build(BuildContext context) => HtmlWidget(
        data,
        baseUrl: Uri.parse(API.BASE_URL),
        buildAsync: buildAsync,
        customWidgetBuilder: buildCustomWidget,
        customStylesBuilder: (element) => buildCustomStyle(context, element),
        onLoadingBuilder: (context, element, progress) {
          String message = 'Rendu…';
          if (progress != null) {
            message += '\n' + progress.toString() + '%';
          }
          return CenteredCircularProgressIndicator(message: message);
        },
        onErrorBuilder: (context, element, error) {
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
        textStyle: textStyle,
        factoryBuilder: () => AppWidgetFactory(textStyle: textStyle),
      );

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
  Map<String, String>? buildCustomStyle(BuildContext context, dom.Element element) {
    Map<String, String> style = {
      if (element.classes.contains('mb-0')) 'margin-bottom': '0',
      if (element.classes.contains('center')) 'text-align': 'center',
    };

    switch (element.localName) {
      case 'h2':
      case 'h3':
      case 'h4':
        return {
          'margin-top': '0',
          'padding-top': '0',
          'margin-bottom': '0',
          'padding-bottom': '0',
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
        AppTheme theme = context.resolveTheme(listen: false);
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
    }

    return null;
  }
}
