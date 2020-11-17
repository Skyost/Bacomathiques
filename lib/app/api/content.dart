import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/app.dart';
import 'package:bacomathiques/app/dialogs.dart' as dialogs;
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  /// Available action bar actions.
  static final List<_ActionMenu> _actions = [
    _ActionMenu(
      icon: Icons.save,
      label: 'Enregistrer le PDF',
      callback: (context, lessonContent) => openURL(API.BASE_URL + lessonContent.pdf),
    ),
    _ActionMenu(
      icon: Icons.subtitles,
      label: 'Publicités…',
      callback: (context, lessonContent) => dialogs.AdsDialog.show(context),
    ),
    _ActionMenu(
      icon: Icons.thumb_up,
      label: 'Noter l\'application',
      callback: (context, lessonContent) => openURL(storePage),
    ),
    _ActionMenu(
      icon: Icons.sms_failed,
      label: 'Signaler un bug',
      callback: (context, lessonContent) => openURL('https://github.com/Skyost/Bacomathiques/issues/new?title=[Application]%20Rapport%20de%20bug'),
    ),
    _ActionMenu(
      icon: Icons.help,
      label: 'À propos…',
      callback: (context, lessonContent) => dialogs.AboutDialog.show(context),
    )
  ];

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
  AppBar createAppBar(BuildContext context) {
    AppTheme appTheme = Provider.of<SettingsModel>(context).appTheme;
    _ActionMenu shareActionMenu = createShareActionMenu();
    return AppBar(
      title: createTitle(lesson.title),
      actions: [
        if (e3c.isEmpty)
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
            onPressed: () => dialogs.E3CDialog.show(context, e3c: e3c),
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
        PopupMenuButton<_ActionMenu>(
          key: e3c.isNotEmpty ? _shareButtonKey : null,
          color: appTheme.themeData.scaffoldBackgroundColor,
          onSelected: (action) => action.callback(context, this),
          itemBuilder: (context) => [
            if (e3c.isNotEmpty) shareActionMenu.createPopupMenuItem(appTheme),
            ..._actions.map((action) => action.createPopupMenuItem(appTheme)),
          ],
        ),
      ],
    );
  }

  /// Creates the title widget.
  static Widget createTitle(String text) {
    List<String> titleParts = text.split(' – ');
    return titleParts.length < 2
        ? Text(text)
        : RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: titleParts.first,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '\n' + titleParts[1],
          ),
        ],
      ),
    );
  }

  /// Creates the share action menu.
  _ActionMenu createShareActionMenu() => _ActionMenu(
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

/// An action menu with text, icon and callback.
class _ActionMenu {
  /// The menu icon.
  final IconData icon;

  /// The menu label.
  final String label;

  /// The callback.
  final Function(BuildContext, LessonContent) callback;

  /// Creates a new action menu.
  const _ActionMenu({
    this.icon,
    this.label,
    this.callback,
  });

  /// Creates and returns the widget corresponding to this action menu.
  Widget createWidget(AppTheme appTheme) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              icon,
              color: appTheme.themeData.textColor ?? Colors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: appTheme.themeData.textColor),
          ),
        ],
      );

  /// Creates the popup menu item associated with this action.
  PopupMenuItem<_ActionMenu> createPopupMenuItem(AppTheme appTheme) => PopupMenuItem<_ActionMenu>(
        value: this,
        child: createWidget(appTheme),
      );
}
