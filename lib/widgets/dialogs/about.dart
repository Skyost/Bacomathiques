import 'package:bacomathiques/utils/utils.dart';
import 'package:bacomathiques/widgets/dialogs/app_alert_dialog.dart';
import 'package:flutter/material.dart';

/// The about dialog.
class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AppAlertDialog.oneChild(
        title: 'À propos de Bacomathiques',
        actions: [
          TextButton(
            onPressed: () => openUrl('https://bacomathiqu.es/a-propos/'),
            child: const Text('Plus d\'informations'),
          ),
          TextButton(
            onPressed: () => openUrl(storePage),
            child: const Text('Fiche de l\'application'),
          ),
          const AppAlertDialogCloseButton(),
        ],
        child: const Text(
          'Révisez vos maths en toute tranquillité de la Première à la Terminale avec Bacomathiques ! Vous pouvez consulter les licences des contenus, technologies utilisées et autres en cliquant sur le bouton « Plus d\'informations ».\nSi vous aimez cette appli, n\'hésitez pas à laisser une (bonne) note sur la fiche de l\'application !',
        ),
      );

  /// Shows the dialog.
  static void show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AboutDialog(),
      );
}
