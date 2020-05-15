import 'dart:io';

import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/app/settings.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Dialog that displays annals.
class AnnalsDialog extends StatelessWidget {
  /// The lesson.
  final List<LessonAnnal> annals;

  /// Creates a new annals dialog.
  const AnnalsDialog({
    @required this.annals,
  });

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: _createTitleWidget(),
        children: annals.map((annal) => _createAnnalWidget(context, annal)).toList(),
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Annales');

  /// Creates a new annal widget.
  Widget _createAnnalWidget(BuildContext context, LessonAnnal annal) => ListTile(
        title: Text(annal.name + ' ' + annal.year.toString()),
        subtitle: Text(annal.specific ? 'Spécifique' : 'Spécialité'),
        onTap: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text(annal.name + ' ' + annal.year.toString() + (annal.specific ? ' (Spécifique)' : ' (Spécialité)')),
              children: [
                ListTile(
                  title: const Text('Énoncé'),
                  onTap: () => openURL(API.BASE_URL + annal.subject),
                ),
                ListTile(
                  title: const Text('Correction'),
                  onTap: () => openURL(API.BASE_URL + annal.correction),
                )
              ],
            ),
          );
        },
      );

  /// Shows the dialog.
  static void show(BuildContext context, {@required List<LessonAnnal> annals}) => showDialog(
        context: context,
        builder: (context) => AnnalsDialog(annals: annals),
      );
}

/// The ads dialog.
class AdsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: createActionsWidgets(context, Provider.of<SettingsModel>(context)),
            direction: Axis.vertical,
          ),
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Publicités');

  /// Creates a new content widget.
  Widget _createContentWidget() => const SingleChildScrollView(
        child: Text(
          'Bacomathiques vous laisse le choix d\'activer ou de désactiver les publicités. Sachez cependant que cette application et son contenu sont mis à disposition gratuitement pour les utilisateurs et que les publicités constituent les seuls revenus de cette application.',
        ),
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context, SettingsModel settingsModel) => [
        FlatButton(
          onPressed: () async {
            settingsModel.adMobEnabled = true;
            await settingsModel.flush();
            _showRestartDialog(context);
          },
          child: Text('Activer les publicités'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () async {
            settingsModel.adMobEnabled = false;
            await settingsModel.flush();
            _showRestartDialog(context);
          },
          child: Text('Désactiver les publicités'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
      ];

  /// Shows a restart dialog.
  void _showRestartDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const SingleChildScrollView(
            child: Text(
              'Choix enregistré ! Il est possible que vous ayez à redémarrer l\'application pour que les changements soient pris en compte.',
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'.toUpperCase()),
              textTheme: ButtonTextTheme.accent,
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
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: createActionsWidgets(context),
            direction: Axis.vertical,
          )
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('À propos');

  /// Creates a new content widget.
  Widget _createContentWidget() => const SingleChildScrollView(
        child: Text(
          'Révisez vos maths en toute tranquillité de la Première à la Terminale avec Bacomathiques !\nVous pouvez consulter les licences des contenus, technologies utilisées et autres en cliquant sur le bouton « Plus d\'informations ».\nSinon, n\'hésitez pas à laisser une (bonne) note sur la fiche de l\'application !',
        ),
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
        FlatButton(
          onPressed: () => openURL('https://bacomathiqu.es/a-propos/'),
          child: Text('Plus d\'informations'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () => openURL(storePage),
          child: Text('Fiche de l\'application'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AboutDialog(),
      );
}

/// The user dialog.
class UserDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new user dialog instance.
  UserDialog({
    @required this.comments,
  }) : _controller = TextEditingController(text: comments.username);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(context),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: createActionsWidgets(context),
            direction: Axis.vertical,
          )
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Utilisateur');

  /// Creates a new content widget.
  Widget _createContentWidget(BuildContext context) => TextField(
        controller: _controller,
        onSubmitted: (username) => Navigator.pop(context),
        decoration: const InputDecoration(
          hintText: 'Nom d\'utilisateur',
        ),
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
        FlatButton(
          onPressed: () {
            comments.username = _controller.text;
            Navigator.pop(context);
          },
          child: Text('Valider'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Annuler'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context, {@required LessonComments comments}) => showDialog(
        context: context,
        builder: (context) => UserDialog(comments: comments),
      );
}

/// The write comment dialog.
class WriteCommentDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new write comment dialog instance.
  WriteCommentDialog({
    @required this.comments,
  }) : _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: createActionsWidgets(context),
            direction: Axis.vertical,
          ),
        ],
      );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('Nouveau commentaire');

  /// Creates a new content widget.
  Widget _createContentWidget() => TextField(
        keyboardType: TextInputType.multiline,
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Exprimez-vous !',
        ),
        maxLines: null,
      );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
        FlatButton(
          onPressed: () async {
            if (_controller.text.isEmpty) {
              await MessageDialog.show(context, message: 'Veuillez entrer un commentaire.');
              return;
            }

            WaitingDialog.show(context, message: 'Envoi en cours, veuillez patienter environ 10 secondes…');
            List<LessonCommentsPostDataFieldValue> fields = [];
            for (LessonCommentsPostDataField field in comments.post.fields) {
              switch (field.name) {
                case 'slug':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: comments.lesson.level + '_' + comments.lesson.id,
                  ));
                  break;
                case 'lesson':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: comments.lesson.id,
                  ));
                  break;
                case 'level':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: comments.lesson.level,
                  ));
                  break;
                case 'client':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: Platform.isIOS ? 'iOS' : 'Android',
                  ));
                  break;
                case 'message':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: _controller.text,
                  ));
                  break;
                case 'author':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: comments.username,
                  ));
                  break;
                default:
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: '?',
                  ));
                  break;
              }
            }

            bool success = await comments.postComment(fields);
            Navigator.pop(context);
            if (success) {
              Navigator.pop(context);
            }

            await MessageDialog.show(
              context,
              message: success ? 'Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu\'il ne sera publié qu\'après modération 😉' : 'Une erreur est survenue pendant l\'envoi de votre commentaire. Veuillez vérifier votre connexion internet ainsi que les données envoyées et réessayez.',
            );
          },
          child: Text('Envoyer'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
          textTheme: ButtonTextTheme.accent,
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context, {@required LessonComments comments}) => showDialog(
        context: context,
        builder: (context) => WriteCommentDialog(comments: comments),
      );
}

/// A simple message dialog.
class MessageDialog extends StatelessWidget {
  /// The message to show.
  final String message;

  /// Action to run when the ok button has been pressed.
  final VoidCallback okButtonPressed;

  /// Creates a new message dialog instance.
  MessageDialog({
    @required this.message,
    this.okButtonPressed,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Ok'.toUpperCase()),
            onPressed: okButtonPressed ?? () => Navigator.pop(context),
            textTheme: ButtonTextTheme.accent,
          ),
        ],
      );

  /// Shows the dialog.
  static Future<void> show(BuildContext context, {@required String message, VoidCallback okButtonPressed, VoidCallback onCancelled}) async {
    await showDialog(
      context: context,
      builder: (context) => MessageDialog(message: message, okButtonPressed: okButtonPressed),
      barrierDismissible: false,
    );
    if (onCancelled != null) {
      onCancelled();
    }
  }
}

/// A dialog that allows to tell the user to wait.
class WaitingDialog extends StatelessWidget {
  /// The wait message.
  final String message;

  /// Creates a new waiting dialog instance.
  const WaitingDialog({
    @required this.message,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Veuillez patienter…'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: CircularProgressIndicator(),
            ),
            Text(
              message,
              style: const TextStyle(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  /// Shows the dialog.
  static void show(BuildContext context, {@required String message}) => showDialog(
        context: context,
        builder: (context) => WaitingDialog(message: message),
        barrierDismissible: false,
      );
}
