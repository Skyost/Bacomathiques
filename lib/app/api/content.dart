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

  /// The "annals" field.
  final List<LessonAnnal> annals;

  /// Creates a new lesson content instance.
  const LessonContent({
    @required this.api,
    @required this.lesson,
    @required this.difficulty,
    @required this.pdf,
    @required this.html,
    @required this.annals,
  });

  /// Creates a new lesson content instance from a parsed JSON string.
  LessonContent.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          api: APIStatus.fromParsedJSON(parsedJSON['api']),
          lesson: Lesson.fromParsedJSON(parsedJSON['lesson']),
          difficulty: parsedJSON['difficulty'],
          pdf: parsedJSON['pdf'],
          html: parsedJSON['html'],
          annals: parsedJSON['annals'].map<LessonAnnal>((annal) => LessonAnnal.fromParsedJSON(annal)).toList(),
        );

  @override
  AppBar createAppBar(BuildContext context) {
    List<_ActionMenu> actions = List.of(_actions);
    if (annals.isNotEmpty) {
      actions.insert(
        0,
        _ActionMenu(
          icon: Icons.assignment_turned_in,
          label: 'Annales…',
          callback: (context, object) => dialogs.AnnalsDialog.show(context, annals: annals),
        ),
      );
    }

    AppTheme appTheme = Provider.of<SettingsModel>(context).appTheme;
    List<String> titleParts = lesson.title.split(' – ');
    return AppBar(
      title: titleParts.length < 2
          ? Text(lesson.title)
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: titleParts.first,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '\n' + titleParts[1],
                  ),
                ],
              ),
            ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () => Share.share('Lisez le cours intitulé « ' + lesson.title + ' » en téléchargeant l\'application Bacomathiques !\n' + storePage),
        ),
        IconButton(
          icon: Icon(
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
          color: appTheme.themeData.scaffoldBackgroundColor,
          onSelected: (action) => action.callback(context, this),
          itemBuilder: (context) => actions
              .map(
                (action) => PopupMenuItem<_ActionMenu>(
                  value: action,
                  child: action.createWidget(appTheme),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

/// A lesson annal.
class LessonAnnal {
  /// The "id" field.
  final String id;

  /// The "name" field.
  final String name;

  /// The "year" field.
  final int year;

  /// The "specific" field.
  final bool specific;

  /// The "subject" field.
  final String subject;

  /// The "correction" field.
  final String correction;

  /// Creates a new lesson annal instance.
  const LessonAnnal({
    @required this.id,
    @required this.name,
    @required this.year,
    @required this.specific,
    @required this.subject,
    @required this.correction,
  });

  /// Creates a new lesson annal instance from a parsed JSON string.
  LessonAnnal.fromParsedJSON(Map<String, dynamic> parsedJSON)
      : this(
          id: parsedJSON['id'],
          name: parsedJSON['name'],
          year: parsedJSON['year'],
          specific: parsedJSON['specific'],
          subject: parsedJSON['subject'],
          correction: parsedJSON['correction'],
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
}
