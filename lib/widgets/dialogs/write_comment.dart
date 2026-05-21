import 'package:bacomathiques/model/api/comments.dart';
import 'package:bacomathiques/model/settings.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:bacomathiques/widgets/dialogs/message.dart';
import 'package:bacomathiques/widgets/dialogs/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The write comment dialog.
class WriteCommentDialog extends ConsumerStatefulWidget {
  /// The current comments instance.
  final LessonComments comments;

  /// Creates a new write comment dialog instance.
  const WriteCommentDialog({
    super.key,
    required this.comments,
  });

  /// Shows the dialog.
  static void show(BuildContext context, {required LessonComments comments}) => showDialog(
        context: context,
        builder: (context) => WriteCommentDialog(comments: comments),
      );

  @override
  ConsumerState createState() => _WriteCommentDialogState();
}

/// The write comment dialog state.
class _WriteCommentDialogState extends ConsumerState<WriteCommentDialog> {
  /// A text editing controller.
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => AppAlertDialog.oneChild(
        title: 'Nouveau commentaire',
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.text.isEmpty) {
                await MessageDialog.show(
                  context,
                  title: 'Avertissement',
                  message: 'Veuillez entrer un commentaire.',
                );
                return;
              }

              WaitingDialog.show(context, message: 'Envoi en cours, veuillez patienter…');
          AppSettings settings = await ref.read(settingsModelProvider.future);
          bool success = await widget.comments.postComment(settings.commentsUsername, controller.text);
          if (context.mounted) {
            Navigator.pop(context);
                if (success) {
                  Navigator.pop(context);
                }

                await MessageDialog.show(
                  context,
                  title: 'Commentaire',
                  message: success
                      ? 'Votre commentaire a été envoyé avec succès. Veuillez cependant noter qu\'il ne sera publié qu\'après modération 😉'
                      : 'Une erreur est survenue pendant l\'envoi de votre commentaire. Veuillez vérifier votre connexion internet ainsi que les données envoyées et réessayez.',
                );
              }
            },
            child: const Text('Envoyer'),
          ),
          const AppAlertDialogCloseButton(),
        ],
        child: TextField(
          keyboardType: TextInputType.multiline,
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Exprimez-vous !',
          ),
          maxLines: null,
        ),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
