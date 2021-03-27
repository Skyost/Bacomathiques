
import 'package:bacomathiques/utils/utils.dart';
import 'package:flutter/material.dart';

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
        direction: Axis.vertical,
        children: createActionsWidgets(context),
      )
    ],
  );

  /// Creates a new title widget.
  Widget _createTitleWidget() => const Text('À propos de Bacomathiques');

  /// Creates a new content widget.
  Widget _createContentWidget() => const SingleChildScrollView(
    child: Text(
      'Révisez vos maths en toute tranquillité de la Première à la Terminale avec Bacomathiques ! Vous pouvez consulter les licences des contenus, technologies utilisées et autres en cliquant sur le bouton « Plus d\'informations ».\nSi vous aimez cette appli, n\'hésitez pas à laisser une (bonne) note sur la fiche de l\'application !',
    ),
  );

  /// Creates a new dialog actions widgets.
  List<Widget> createActionsWidgets(BuildContext context) => [
    TextButton(
      onPressed: () => openURL('https://bacomathiqu.es/a-propos/'),
      child: Text('Plus d\'informations'.toUpperCase()),
    ),
    TextButton(
      onPressed: () => openURL(storePage),
      child: Text('Fiche de l\'application'.toUpperCase()),
    ),
    TextButton(
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