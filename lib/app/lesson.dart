import 'dart:convert';

import 'package:bacomathiques/main.dart';
import 'package:bacomathiques/util/util.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

/// Represents an API object.
abstract class APIObject {
  /// The website address.
  static const WEBSITE = 'https://bacomathiqu.es/';

  /// The API path.
  static const API_PATH = WEBSITE + 'api/v1/';

  /// The object identifier.
  final String id;

  /// The object title.
  final String title;

  /// The object main content.
  final String content;

  /// All actions that should be displayed.
  final List<ActionMenu> actions;

  /// Creates a new API object instance.
  const APIObject(this.id, this.title, this.content, this.actions);
}

/// Represents a lesson preview with a title, a picture and a description.
class Preview extends APIObject {
  /// Path to previews.
  static const PREVIEWS_PATH = 'lessons.json';

  /// The current preview image URL.
  final String previewImage;

  /// The preview image caption.
  final String caption;

  /// The content URL.
  final String contentURL;

  /// The summary URL.
  final String summaryURL;

  /// Creates a new lesson preview instance.
  Preview(String id, String title, String content, this.previewImage, this.caption, this.contentURL, this.summaryURL) : super(id, title, content, []);

  /// Requests to load the list of available previews.
  static Future<List<Preview>> request() async {
    String content = await getAndSave('previews', 'content', APIObject.API_PATH + PREVIEWS_PATH);
    if (content == null) {
      return null;
    }

    List<dynamic> previews = json.decode(content);
    return List.of(previews.map((preview) => Preview(preview['id'], preview['title'], HtmlUnescape().convert(preview['excerpt']).replaceAll("<q>", "« <em>").replaceAll('</q>', '</em> »'), preview['preview'], HtmlUnescape().convert(preview['caption']), preview['content'], preview['summary'])));
  }
}

/// Represents a lesson.
class Lesson extends APIObject {
  /// Available action bar actions.
  static final _actions = [
    ActionMenu(Icons.assignment_turned_in, 'Annales…', (context, object) => AnnalsDialog.show(context, object as Lesson)),
    ActionMenu(Icons.save, 'Enregistrer le PDF', (context, object) => openURL(APIObject.WEBSITE + 'assets/pdf/lessons/' + Uri.encodeComponent(object.title.replaceAll('é', 'e').replaceAll('É', 'E')) + '.pdf')),
    ActionMenu(Icons.subtitles, 'Publicités…', (context, object) => AdsDialog.show(context)),
    ActionMenu(Icons.thumb_up, 'Noter l\'application', (context, object) => openURL(storePage)),
    ActionMenu(Icons.sms_failed, 'Signaler un bug', (context, object) => openURL('https://github.com/Skyost/Bacomathiques/issues/new?title=[Application]%20Rapport%20de%20bug')),
    ActionMenu(Icons.help, 'À Propos…', (context, object) => AboutDialog.show(context))
  ];

  /// List of annals.
  final List<String> annals;

  /// Creates a new lesson instance.
  Lesson(String id, String title, String content, this.annals) : super(id, title, content, _actions);

  /// Requests to load the specified lesson.
  static Future<Lesson> request(String relativeURL) async {
    String content = await getAndSave('lessons', relativeURL, APIObject.WEBSITE + relativeURL);
    if (content == null) {
      return null;
    }

    Map<String, dynamic> lesson = json.decode(content);
    List<String> annals = [];
    lesson['annals'].forEach((id) => annals.add(id));

    return Lesson(
      lesson['id'],
      lesson['title'],
      HtmlUnescape().convert(lesson['content']),
      annals,
    );
  }
}

/// Represents a lesson summary.
class Summary extends APIObject {
  /// Creates a new lesson summary instance.
  Summary(String id, String title, String content) : super(id, title, content, []);

  /// Requests to load the specified lesson summary.
  static Future<Summary> request(String relativeURL) async {
    String content = await getAndSave('summaries', relativeURL, APIObject.WEBSITE + relativeURL);
    if (content == null) {
      return null;
    }

    Map<String, dynamic> summary = json.decode(content);
    return Summary(
      summary['id'],
      summary['title'],
      HtmlUnescape().convert(summary['content']),
    );
  }
}

/// An action menu with text, icon and callback.
class ActionMenu {
  /// The menu icon.
  final IconData _icon;

  /// The menu label.
  final String _label;

  /// The callback.
  final Function(BuildContext, APIObject) callback;

  /// Creates a new action menu.
  ActionMenu(this._icon, this._label, this.callback);

  /// Creates and returns the widget corresponding to this action menu.
  Widget createWidget() => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              _icon,
              color: Colors.black,
            ),
          ),
          Text(
            _label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      );
}

/// Dialog that displays annals.
class AnnalsDialog extends StatelessWidget {
  /// The lesson.
  final Lesson _lesson;

  /// Creates a new annals dialog.
  AnnalsDialog(this._lesson);

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: _createTitleWidget(),
        children: _lesson.annals.map((annal) => _createAnnalWidget(context, annal)).toList(),
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => Text('Annales');

  /// Creates a new annal widget.
  Widget _createAnnalWidget(BuildContext context, String annal) {
    List<String> parts = annal.split('/');
    SimpleDialogOption result = SimpleDialogOption(
      child: Text((parts[4] + ' ' + parts[5] + ' ' + parts[3]).toUpperCase()),
      onPressed: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => SimpleDialog(
                children: [
                  SimpleDialogOption(
                    child: Text('Énoncé'),
                    onPressed: () => openURL(APIObject.WEBSITE + annal + 'enonce.pdf'),
                  ),
                  SimpleDialogOption(
                    child: Text('Correction'),
                    onPressed: () => openURL(APIObject.WEBSITE + annal + 'correction.pdf'),
                  )
                ],
              ),
        );
      },
    );
    return result;
  }

  /// Shows the dialog.
  static void show(BuildContext context, Lesson lesson) => showDialog(
        context: context,
        builder: (context) => AnnalsDialog(lesson),
      );
}

/// The ads dialog.
class AdsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: createActionsWidgets(context),
          )
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => Text('Publicités');

  /// Creates a new content widget.
  Widget _createContentWidget() => SingleChildScrollView(
        child: Text(
          'Bacomathiques vous laisse le choix d\'activer ou de désactiver les publicités. Sachez cependant que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités constituent les seuls revenus de cette application.',
        ),
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
        FlatButton(
          onPressed: () {
            adMob.setEnabled(true);
            _showRestartDialog(context);
          },
          child: Text('Activer les publicités'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () {
            adMob.setEnabled(false);
            _showRestartDialog(context);
          },
          child: Text('Désactiver les publicités'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
        ),
      ];

  /// Shows a restart dialog.
  void _showRestartDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Text(
                  'Choix enregistré ! Il est possible que vous ayez à redémarrer l\'application pour que les changements soient pris en compte.',
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok'.toUpperCase()),
                ),
              ],
            ),
      );

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AdsDialog(),
      );
}

/// The about dialog.
class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: createActionsWidgets(context),
          )
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => Text('À Propos');

  /// Creates a new content widget.
  Widget _createContentWidget() => SingleChildScrollView(
        child: Text(
          'Révisez votre BAC de mathématiques avec Bacomathiques !\nVous pouvez consulter les licences des contenus, technologies utilisées et autres en cliquant sur le bouton « Plus d\'informations ».\nSinon, n\'hésitez pas à laisser une (bonne) note sur la fiche de l\'application !',
        ),
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
        FlatButton(
          onPressed: () => openURL('https://bacomathiqu.es/a-propos/'),
          child: Text('Plus d\'informations'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => openURL(storePage),
          child: Text('Fiche de l\'application'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AboutDialog(),
      );
}
