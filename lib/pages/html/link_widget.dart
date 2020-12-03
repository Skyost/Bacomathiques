import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Allows to display a link.
class LinkWidget extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The href.
  final String href;

  /// The lesson level (if any).
  final String level;

  /// The lesson (if any).
  final String lesson;

  /// The hash (if any).
  final String hash;

  /// The target endpoint (if any).
  final LessonContentEndpoint targetLessonEndpoint;

  /// The text style.
  final TextStyle textStyle;

  /// Creates a new link widget.
  const LinkWidget({
    @required this.text,
    @required this.href,
    this.level,
    this.lesson,
    this.hash,
    this.targetLessonEndpoint,
    this.textStyle = const TextStyle(),
  });

  LinkWidget.fromElement({
    @required dom.Element element,
    TextStyle textStyle = const TextStyle(),
  }) : this(
          text: element.text,
          href: element.attributes['href'],
          level: element.attributes['data-api-v2-level'],
          lesson: element.attributes['data-api-v2-lesson'],
          hash: element.attributes['data-api-v2-hash'],
          targetLessonEndpoint: element.attributes.containsKey('data-target-lesson-endpoint') ? LessonContentEndpoint(path: element.attributes['data-target-lesson-endpoint']) : null,
          textStyle: textStyle,
        );

  @override
  Widget build(BuildContext context) {
    BubbleTheme bubbleTheme;
    try {
      bubbleTheme = context.watch<BubbleTheme>();
    } on ProviderNotFoundException catch (_) {}
    bubbleTheme ??= context.watch<SettingsModel>().appTheme.themeData.bubbleThemes[Bubble.FORMULA];

    return GestureDetector(
      onTap: () async {
        LessonContentEndpoint endpoint = targetLessonEndpoint;
        if (endpoint == null && (level != null && lesson != null)) {
          endpoint = LessonContentEndpoint.fromLevelAndLesson(
            level: level,
            lesson: lesson,
          );
        }

        if (endpoint != null) {
          await Navigator.pushReplacementNamed(context, '/html', arguments: {'endpoint': endpoint, 'anchor': hash});
        }
        else if (await canLaunch(href)) {
          await launch(href);
        }
      },
      child: Text(
        text,
        style: textStyle.copyWith(
          color: bubbleTheme.linkColor,
          decoration: TextDecoration.underline,
          decorationColor: bubbleTheme.linkDecorationColor,
        ),
      ),
    );
  }
}
