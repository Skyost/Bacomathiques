import 'dart:io';

import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/api/common.dart';
import 'package:bacomathiques/app/api/content.dart';
import 'package:bacomathiques/main.dart';
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';

/// Dialog that displays annals.
class AnnalsDialog extends StatelessWidget {
  /// The lesson.
  final List<LessonAnnal> _annals;

  /// Creates a new annals dialog.
  AnnalsDialog(this._annals);

  @override
  Widget build(BuildContext context) => SimpleDialog(
        title: _createTitleWidget(),
        children: _annals.map((annal) => _createAnnalWidget(context, annal)).toList(),
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
              children: [
                SimpleDialogOption(
                  child: const Text('Énoncé'),
                  onPressed: () => openURL(API.BASE_URL + annal.subject),
                ),
                SimpleDialogOption(
                  child: const Text('Correction'),
                  onPressed: () => openURL(API.BASE_URL + annal.correction),
                )
              ],
            ),
          );
        },
      );

  /// Shows the dialog.
  static void show(BuildContext context, List<LessonAnnal> annals) => showDialog(
        context: context,
        builder: (context) => AnnalsDialog(annals),
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
            children: createActionsWidgets(context),
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
          content: const SingleChildScrollView(
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
          Wrap(
            alignment: WrapAlignment.end,
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

/// The user dialog.
class UserDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments _comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new user dialog instance.
  UserDialog(this._comments) : _controller = TextEditingController(text: _comments.username);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(context),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
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
            _comments.username = _controller.text;
            Navigator.pop(context);
          },
          child: Text('Valider'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Annuler'.toUpperCase()),
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context, LessonComments comments) => showDialog(
        context: context,
        builder: (context) => UserDialog(comments),
      );
}

/// The write comment dialog.
class WriteCommentDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments _comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new write comment dialog instance.
  WriteCommentDialog(this._comments) : _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: _createTitleWidget(),
        content: _createContentWidget(),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
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
          onPressed: () {
            if (_controller.text.isEmpty) {
              MessageDialog.show(context, 'Veuillez entrer un commentaire.');
              return;
            }

            WaitingDialog.show(context, 'Envoi en cours, veuillez patienter…');
            List<LessonCommentsPostDataFieldValue> fields = [];
            for (LessonCommentsPostDataField field in _comments.post.fields) {
              switch (field.name) {
                case 'slug':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: _comments.lesson.level + '_' + _comments.lesson.id,
                  ));
                  break;
                case 'lesson':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: _comments.lesson.id,
                  ));
                  break;
                case 'level':
                  fields.add(LessonCommentsPostDataFieldValue(
                    field: field,
                    value: _comments.lesson.level,
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
                    value: _comments.username,
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

            _comments.postComment(fields).then((success) {
              Navigator.pop(context);
              if (success) {
                Navigator.pop(context);
              }

              MessageDialog.show(
                context,
                success ? 'Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu\'il ne sera publié qu\'après modération 😉' : 'Une erreur est survenue pendant l\'envoi de votre commentaire. Veuillez vérifier votre connexion internet ainsi que les données envoyées et réessayez.',
              );
            });
          },
          child: Text('Envoyer'.toUpperCase()),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Fermer'.toUpperCase()),
        ),
      ];

  /// Shows the dialog.
  static void show(BuildContext context, LessonComments comments) => showDialog(
        context: context,
        builder: (context) => WriteCommentDialog(comments),
      );
}

/// A simple message dialog.
class MessageDialog extends StatelessWidget {
  /// The message to show.
  final String message;

  /// Action to run when the ok button has been pressed.
  final VoidCallback okButtonPressed;

  /// Creates a new message dialog instance.
  MessageDialog(this.message, [this.okButtonPressed]);

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('Ok'.toUpperCase()),
            onPressed: okButtonPressed ?? () => Navigator.pop(context),
          ),
        ],
      );

  /// Shows the dialog.
  static void show(BuildContext context, String message, [VoidCallback okButtonPressed, VoidCallback onCancelled]) {
    showDialog(
      context: context,
      builder: (context) => MessageDialog(message, okButtonPressed),
      barrierDismissible: false,
    ).then((value) => onCancelled == null ? null : onCancelled());
  }
}

/// A dialog that allows to tell the user to wait.
class WaitingDialog extends StatelessWidget {
  /// The wait message.
  final String message;

  /// Creates a new waiting dialog instance.
  WaitingDialog(this.message);

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
              style: Theme.of(context).textTheme.body1.copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  /// Shows the dialog.
  static void show(BuildContext context, String message) => showDialog(
        context: context,
        builder: (context) => WaitingDialog(message),
        barrierDismissible: false,
      );
}
