import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/dialogs/e3c.dart';
import 'package:bacomathiques/app/theme/theme.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart' hide AboutDialog;
import 'package:share_plus/share_plus.dart';

/// /api/v2/:level/:lesson/ endpoint.
class LessonContentEndpoint extends APIEndpoint<LessonContent> {
  /// Creates a new lesson content endpoint instance.
  const LessonContentEndpoint({
    required String path,
  }) : super(
          path: path,
        );

  /// Creates a new lesson content endpoint instance from a level and a lesson.
  const LessonContentEndpoint.fromLevelAndLesson({
    required String level,
    required String lesson,
  }) : super(
          path: '/api/v2/$level/$lesson/',
        );

  @override
  LessonContent createObjectFromJSON(Map<String, dynamic> parsedJSON) => LessonContent.fromParsedJSON(parsedJSON);
}

/// A lesson content object.
class LessonContent extends APIEndpointResultHTML {
  /// The "api" field.
  final APIStatus api;

  /// The "lesson" field.
  @override
  final Lesson lesson;

  /// The "difficulty" field.
  final int difficulty;

  /// The "pdf" field.
  final String pdf;

  /// The "html" field.
  @override
  final String html;

  /// The "e3c" field.
  final List<LessonE3C> e3c;

  /// Creates a new lesson content instance.
  const LessonContent({
    required this.api,
    required this.lesson,
    required this.difficulty,
    required this.pdf,
    required this.html,
    required this.e3c,
  });

  /// Creates a new lesson content instance from a parsed JSON string.
  LessonContent.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
          difficulty: parsedJSON['difficulty'],
          pdf: parsedJSON['pdf'],
          html: parsedJSON['html'],
          e3c: parsedJSON['e3c'].map<LessonE3C>((e3c) => LessonE3C.fromParsedJSON(e3c)).toList(),
        );

  @override
  AppBar createAppBar(BuildContext context, AppTheme theme, {GlobalKey? shareButtonKey}) => AppBar(
    title: createTitle(context),
    actions: createActions(context, theme, shareButtonKey: shareButtonKey),
  );

  @override
  List<Widget> createActions(BuildContext context, AppTheme theme, {GlobalKey? shareButtonKey}) {
    ActionMenu? shareActionMenu = e3c.isEmpty ? createShareActionMenu(shareButtonKey) : null;
    return [
      if (shareActionMenu != null)
        IconButton(
          key: shareButtonKey,
          icon: Icon(
            shareActionMenu.icon,
            color: Colors.white,
          ),
          onPressed: () => shareActionMenu.callback(context, null),
        ),
      if (e3c.isNotEmpty)
        IconButton(
          icon: const Icon(
            Icons.assignment_turned_in,
            color: Colors.white,
          ),
          onPressed: () => E3CDialog.show(context, e3c: e3c),
        ),
      IconButton(
        icon: const Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/comments', arguments: {
            'endpoint': lesson.comments,
          });
        },
      ),
      createPopupMenuButton(context, theme),
    ];
  }

  @override
  Widget createPopupMenuButton(BuildContext context, AppTheme theme, {GlobalKey? shareButtonKey}) => e3c.isEmpty
      ? super.createPopupMenuButton(context, theme)
      : Container(
          key: shareButtonKey,
          child: super.createPopupMenuButton(context, theme),
        );

  @override
  List<ActionMenu> createActionMenus(BuildContext context, {GlobalKey? shareButtonKey}) => [
        if (e3c.isNotEmpty) createShareActionMenu(shareButtonKey),
        ActionMenu(
          icon: Icons.save,
          label: 'Enregistrer le PDF',
          callback: (context, endpointResult) => openURL(API.baseUrl + (endpointResult as LessonContent).pdf),
        ),
        ...super.createActionMenus(context),
      ];

  /// Creates the share action menu.
  ActionMenu createShareActionMenu(GlobalKey? shareButtonKey) => ActionMenu(
      icon: Icons.share,
      label: 'Partager le cours…',
      callback: (context, content) async {
        Rect? sharePositionOrigin;
        if (shareButtonKey != null) {
          RenderBox? renderBox = shareButtonKey.currentContext?.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            Offset position = renderBox.localToGlobal(Offset.zero);
            sharePositionOrigin = Rect.fromLTWH(position.dx, position.dy, 24, 12);
          }
        }

        await Share.share(
          'Lisez le cours intitulé « ${lesson.title} » en téléchargeant l\'application Bacomathiques !\n$storePage',
          subject: 'Bacomathiques - ${lesson.title}',
          sharePositionOrigin: sharePositionOrigin,
        );
      });
}

/// Represents an E3C.
class LessonE3C {
  /// The "id" field.
  final String id;

  /// The "subject" field.
  final String subject;

  /// The "corrections" field.
  final List<String> corrections;

  /// Creates a new lesson E3C instance.
  const LessonE3C({
    required this.id,
    required this.subject,
    required this.corrections,
  });

  /// Creates a new lesson E3C instance from a parsed JSON string.
  LessonE3C.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          subject: parsedJSON['subject'],
          corrections: List<String>.from(parsedJSON['corrections']),
        );
}
