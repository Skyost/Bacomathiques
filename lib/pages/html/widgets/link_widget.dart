import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/theme/bubble.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fwfh_text_style/fwfh_text_style.dart';
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

/// Allows to display a link.
class LinkWidget extends StatelessWidget {
  /// Allows to match URL parts.
  static final RegExp urlParts = RegExp(r'/cours/([A-Za-zÀ-ÖØ-öø-ÿ0-9\-\_]+)/([A-Za-zÀ-ÖØ-öø-ÿ0-9\-\_]+)/?(#[A-Za-zÀ-ÖØ-öø-ÿ0-9\-\_]+)?');

  /// The text to display.
  final String text;

  /// The href.
  final String href;

  /// The current endpoint.
  final String currentEndpoint;

  /// The parent bubble (if any).
  final Bubble? bubble;

  /// The text size.
  final double fontSize;

  /// Creates a new link widget.
  const LinkWidget({
    required this.text,
    required this.href,
    required this.currentEndpoint,
    this.bubble,
    this.fontSize = 16,
  });

  LinkWidget.fromElement({
    required dom.Element element,
    double fontSize = 16,
  }) : this(
          text: element.text,
          href: element.attributes['href']!,
          currentEndpoint: element.attributes['data-current-endpoint']!,
          bubble: BubbleUtils.getByClassName(element.attributes['data-parent-bubble']),
          fontSize: fontSize,
        );

  @override
  Widget build(BuildContext context) {
    BubbleTheme bubbleTheme = context.resolveTheme().bubbleThemes[bubble ?? Bubble.FORMULA]!;
    return GestureDetector(
      onTap: () async {
        LessonContentEndpoint? endpoint = _targetLessonEndpoint;
        if (endpoint != null) {
          await Navigator.pushReplacementNamed(context, '/html', arguments: {'endpoint': endpoint, 'anchor': _targetLessonEndpointHash});
        } else if (await canLaunch(href)) {
          await launch(href);
        }
      },
      child: Text(
        text,
        style: FwfhTextStyle.from(
          TextStyle(
            fontSize: fontSize,
            color: bubbleTheme.linkColor,
            decoration: TextDecoration.underline,
            decorationColor: bubbleTheme.linkDecorationColor,
          ),
        ),
      ),
    );
  }

  /// Returns the target lesson endpoint.
  LessonContentEndpoint? get _targetLessonEndpoint {
    if (href.startsWith('#')) {
      return LessonContentEndpoint(path: currentEndpoint);
    }

    RegExpMatch? firstMatch = urlParts.firstMatch(href);
    if (firstMatch == null || firstMatch.groupCount < 3) {
      return null;
    }

    return LessonContentEndpoint.fromLevelAndLesson(
      level: firstMatch.group(1)!,
      lesson: firstMatch.group(2)!,
    );
  }

  /// Returns the target lesson endpoint hash.
  String? get _targetLessonEndpointHash {
    if (href.startsWith('#')) {
      return Uri.decodeFull(href.substring(1));
    }

    RegExpMatch? firstMatch = urlParts.firstMatch(href);
    if (firstMatch != null && firstMatch.groupCount >= 4) {
      return Uri.decodeFull(firstMatch.group(3)!);
    }

    return null;
  }
}
