import 'dart:io';

import 'package:bacomathiques/app/api/comments.dart';
import 'package:bacomathiques/app/dialogs/message.dart';
import 'package:bacomathiques/app/dialogs/waiting.dart';
import 'package:flutter/material.dart';

/// The write comment dialog.
class WriteCommentDialog extends StatelessWidget {
  /// The current comments instance.
  final LessonComments comments;

  /// A text editing controller.
  final TextEditingController _controller;

  /// Creates a new write comment dialog instance.
  WriteCommentDialog({
    required this.comments,
  }) : _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: _createTitleWidget(),
    content: _createContentWidget(),
    actions: [
      Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.end,
        direction: Axis.vertical,
        children: createActionsWidgets(context),
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
    TextButton(
      onPressed: () async {
        if (_controller.text.isEmpty) {
          await MessageDialog.show(context, message: 'Veuillez entrer un commentaire.');
          return;
        }

        WaitingDialog.show(context, message: 'Envoi en cours, veuillez patienter…');
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
    ),
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Fermer'.toUpperCase()),
    ),
  ];

  /// Shows the dialog.
  static void show(BuildContext context, {required LessonComments comments}) => showDialog(
    context: context,
    builder: (context) => WriteCommentDialog(comments: comments),
  );
}
