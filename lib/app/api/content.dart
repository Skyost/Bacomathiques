import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/dialogs/e3c.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart' hide AboutDialog;
import 'package:share/share.dart';

/// /api/v2/:level/:lesson/ endpoint.
class LessonContentEndpoint extends APIEndpoint<LessonContent> {
  /// Creates a new lesson content endpoint instance.
  const LessonContentEndpoint({
    @required String path,
  }) : super(
          path: path,
        );

  /// Creates a new lesson content endpoint instance from a level and a lesson.
  const LessonContentEndpoint.fromLevelAndLesson({
    @required String level,
    @required String lesson,
  }) : super(
          path: '/api/v2/$level/$lesson/',
        );

  @override
  LessonContent createObjectFromJSON(Map<String, dynamic> parsedJSON) => LessonContent.fromParsedJSON(parsedJSON);
}

/// A lesson content object.
class LessonContent extends APIEndpointResultHTML {
  /// The share button key.
  final GlobalKey _shareButtonKey = GlobalKey();

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
  LessonContent({
    @required this.api,
    @required this.lesson,
    @required this.difficulty,
    @required this.pdf,
    @required this.html,
    @required this.e3c,
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
  List<Widget> createActions(BuildContext context) {
    ActionMenu shareActionMenu = e3c.isEmpty ? createShareActionMenu() : null;
    return [
      if (shareActionMenu != null)
        IconButton(
          key: _shareButtonKey,
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
      ...super.createActions(context),
    ];
  }

  @override
  Widget createPopupMenuButton(BuildContext context) => e3c.isEmpty
      ? super.createPopupMenuButton(context)
      : Container(
          key: _shareButtonKey,
          child: super.createPopupMenuButton(context),
        );

  @override
  List<ActionMenu> createActionMenus(BuildContext context) => [
        if (e3c.isNotEmpty) createShareActionMenu(),
        ActionMenu(
          icon: Icons.save,
          label: 'Enregistrer le PDF',
          callback: (context, endpointResult) => openURL(API.BASE_URL + (endpointResult as LessonContent).pdf),
        ),
        ...super.createActionMenus(context),
      ];

  /// Creates the share action menu.
  ActionMenu createShareActionMenu() => ActionMenu(
      icon: Icons.share,
      label: 'Partager le cours…',
      callback: (context, content) async {
        RenderBox renderBox = _shareButtonKey.currentContext.findRenderObject();
        Offset position = renderBox.localToGlobal(Offset.zero);

        await Share.share(
          'Lisez le cours intitulé « ' + lesson.title + ' » en téléchargeant l\'application Bacomathiques !\n' + storePage,
          sharePositionOrigin: Rect.fromLTWH(position.dx, position.dy, 24, 12),
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
    @required this.id,
    @required this.subject,
    @required this.corrections,
  });

  /// Creates a new lesson E3C instance from a parsed JSON string.
  LessonE3C.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          subject: parsedJSON['subject'],
          corrections: List<String>.from(parsedJSON['corrections']),
        );
}
